
sroa_block_copies.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<from_ptr>:
               	movq	(%rdi), %rax
               	movq	0x8(%rdi), %rcx
               	addq	%rcx, %rax
               	retq

<from_ptr_inl>:
               	movq	(%rdi), %rax
               	movq	0x8(%rdi), %rcx
               	addq	%rcx, %rax
               	retq

<local_copy>:
               	leaq	(%rdi,%rsi), %rax
               	retq

<literal_ptr>:
               	movq	%rsi, (%rdi)
               	movq	$0x7, 0x8(%rdi)
               	retq

<by_value>:
               	movq	%rsi, %rdx
               	leaq	0x1(%rdi), %rax
               	retq

<nested>:
               	movl	(%rdi), %eax
               	movq	0x8(%rdi), %rcx
               	movzbq	0x18(%rdi), %rdx
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	movsbq	%dl, %rcx
               	addq	%rcx, %rax
               	retq

<union_one_width>:
               	movq	%rdi, %rax
               	retq

<union_two_widths>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	movq	%rsi, -0x8(%rbp)
               	movl	$0x5, -0x8(%rbp)
               	movq	(%rax), %r10
               	movq	%r10, (%rdi)
               	movq	-0x8(%rbp), %rax
               	movl	%eax, %eax
               	leave
               	retq

<bitfield_copy>:
               	movq	%rsi, %rcx
               	andq	$0xfff, %rcx            # imm = 0xFFF
               	shlq	$0x8, %rcx
               	orq	$0x8d, %rcx
               	movl	%ecx, (%rdi)
               	movl	$0x0, 0x4(%rdi)
               	movq	%rsi, 0x8(%rdi)
               	retq

<padded_copy>:
               	movsbq	%sil, %rcx
               	leaq	(%rsi,%rsi,2), %rdx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdi)
               	movb	$0x0, 0x1(%rdi)
               	movw	$0x0, 0x2(%rdi)
               	movl	$0x0, 0x4(%rdi)
               	movq	%rdx, 0x8(%rdi)
               	retq

<fam_copy>:
               	movq	%rsi, (%rdi)
               	movq	0x8(%rdi), %rax
               	addq	%rsi, %rax
               	retq

<self_assign>:
               	movq	%rdi, %rax
               	subq	%rsi, %rax
               	retq

<member_copy>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x20(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	%rdi, -0x20(%rbp)
               	movq	%rsi, -0x18(%rbp)
               	movq	%rsi, -0x10(%rbp)
               	movq	%rdi, -0x8(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	addq	$0x10, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movl	$0x1, %eax
               	movq	%rax, -0x10(%rbp)
               	movq	-0x20(%rbp), %rcx
               	imulq	$0xa, %rcx, %rcx
               	movq	-0x18(%rbp), %rdx
               	addq	%rdx, %rcx
               	imulq	$0x64, %rax, %rax
               	addq	%rcx, %rax
               	leave
               	retq

<volatile_copy>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rax
               	movq	$0x0, -0x10(%rbp)
               	movq	$0x0, -0x8(%rbp)
               	movq	%rsi, -0x10(%rbp)
               	leaq	0x1(%rsi), %rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	movq	(%rax), %rsi
               	movq	%rsi, (%rdi)
               	movq	0x8(%rax), %rax
               	movq	%rax, 0x8(%rdi)
               	leaq	(%rcx,%rdx), %rax
               	leave
               	retq

<clobber>:
               	movq	$-0x1, (%rdi)
               	movq	$-0x2, 0x8(%rdi)
               	retq

<escape_after_copy>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	leaq	-0x10(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rsi, -0x10(%rbp)
               	movq	%rsi, %rax
               	shlq	%rax
               	movq	%rax, -0x8(%rbp)
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rbx)
               	callq	<addr>
               	movq	-0x10(%rbp), %rax
               	movq	-0x8(%rbp), %rcx
               	addq	%rcx, %rax
               	movq	(%rbx), %rcx
               	addq	%rcx, %rax
               	movq	0x8(%rbx), %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	leave
               	retq

<take>:
               	leaq	(%rdi,%rdi,2), %rax
               	addq	%rsi, %rax
               	retq

<by_value_arg>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %rax
               	leaq	-0x10(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rsi, -0x10(%rbp)
               	movq	$0x4, -0x8(%rbp)
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	leave
               	retq

<make_pair>:
               	movq	%rdi, %rax
               	movl	$0x9, %edx
               	retq

<make_large>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	leaq	0x2(%rsi), %rdx
               	movq	-0x20(%rbp), %rax
               	movq	%rsi, (%rax)
               	movq	$0x1, 0x8(%rax)
               	movq	%rdx, 0x10(%rax)
               	leave
               	retq

<large_return_inlined>:
               	leaq	0x3(%rdi), %rax
               	addq	$0x4, %rax
               	retq

<jump_back>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rdi      # <addr>
               	movl	$0x1, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2

<copy_across_setjmp>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%r12, (%rbx)
               	movq	$0x5, 0x8(%rbx)
               	leaq	0x5(%r12), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	callq	<addr>
               	ud2

<vla_copy>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rsi, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rcx
               	subq	%r11, %rcx
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rcx, %rsp
               	leaq	-0x1(%rsi), %rdx
               	movl	$0x3, %eax
               	movb	%al, (%rcx,%rdx)
               	movq	(%rdi), %rcx
               	movq	0x8(%rdi), %rdx
               	movsbq	%al, %rax
               	addq	%rdx, %rax
               	addq	%rcx, %rax
               	leave
               	retq

<big_copy>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	leaq	-0x80(%rbp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rsi), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	movups	0x30(%rsi), %xmm14
               	movups	%xmm14, 0x30(%rax)
               	movups	0x40(%rsi), %xmm14
               	movups	%xmm14, 0x40(%rax)
               	movups	0x50(%rsi), %xmm14
               	movups	%xmm14, 0x50(%rax)
               	movups	0x60(%rsi), %xmm14
               	movups	%xmm14, 0x60(%rax)
               	movups	0x70(%rsi), %xmm14
               	movups	%xmm14, 0x70(%rax)
               	movq	%rdx, -0x68(%rbp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movups	0x20(%rax), %xmm14
               	movups	%xmm14, 0x20(%rdi)
               	movups	0x30(%rax), %xmm14
               	movups	%xmm14, 0x30(%rdi)
               	movups	0x40(%rax), %xmm14
               	movups	%xmm14, 0x40(%rdi)
               	movups	0x50(%rax), %xmm14
               	movups	%xmm14, 0x50(%rdi)
               	movups	0x60(%rax), %xmm14
               	movups	%xmm14, 0x60(%rdi)
               	movups	0x70(%rax), %xmm14
               	movups	%xmm14, 0x70(%rdi)
               	movq	0x18(%rdi), %rax
               	movq	0x78(%rdi), %rcx
               	addq	%rcx, %rax
               	leave
               	retq

<array_member_copy>:
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rsi, (%rdi)
               	leaq	0x5(%rsi), %rax
               	movq	%rax, 0x8(%rdi)
               	retq

<wide_copy>:
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movups	%xmm14, 0x20(%rdi)
               	movups	%xmm14, 0x30(%rdi)
               	movups	%xmm14, 0x40(%rdi)
               	movups	%xmm14, 0x50(%rdi)
               	movups	%xmm14, 0x60(%rdi)
               	movups	%xmm14, 0x70(%rdi)
               	movq	%rsi, (%rdi)
               	leaq	0x1(%rsi), %rax
               	movq	%rax, 0x78(%rdi)
               	retq

<fp_copy>:
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rsi, %xmm0
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movsd	%xmm0, (%rdi)
               	movq	%rax, %xmm14
               	movsd	%xmm14, 0x8(%rdi)
               	retq

<sub_object_copy>:
               	leaq	0x2(%rsi), %rax
               	movq	%rsi, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	retq

<chain_copy>:
               	movq	%rsi, (%rdi)
               	movq	%rdx, 0x8(%rdi)
               	retq

<field_literals>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x0, -0x8(%rbp)
               	movq	%rdi, %rax
               	andq	$0xff, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	0x1(%rdi), %rax
               	movl	-0x8(%rbp), %ecx
               	movl	$0xffff00ff, %r11d      # imm = 0xFFFF00FF
               	andq	%r11, %rcx
               	shlq	$0x8, %rax
               	andq	$0xff00, %rax           # imm = 0xFF00
               	orq	%rcx, %rax
               	movl	%eax, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	movl	$0xfffeffff, %r11d      # imm = 0xFFFEFFFF
               	andq	%r11, %rax
               	orq	$0x10000, %rax          # imm = 0x10000
               	movl	%eax, -0x8(%rbp)
               	movl	-0x8(%rbp), %eax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x2a0, %rsp            # imm = 0x2A0
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rbx
               	leaq	-0x290(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rbx, -0x290(%rbp)
               	leaq	0x1(%rbx), %rax
               	movq	%rax, -0x288(%rbp)
               	callq	<addr>
               	movq	%rbx, %rcx
               	shlq	%rcx
               	incq	%rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x290(%rbp), %rdi
               	callq	<addr>
               	movq	%rbx, %rcx
               	shlq	%rcx
               	incq	%rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x4, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	0x4(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x280(%rbp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	movq	-0x280(%rbp), %rax
               	cmpq	%rbx, %rax
               	jne	<addr>
               	movq	-0x278(%rbp), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x290(%rbp), %rdi
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	leaq	0x1(%rbx), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x1b8(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movl	%ebx, -0x1b8(%rbp)
               	movq	$0x2, -0x1b0(%rbp)
               	movq	$0x3, -0x1a8(%rbp)
               	movb	$0x78, -0x1a0(%rbp)
               	callq	<addr>
               	leaq	0x7a(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rbx, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x298(%rbp), %rdi
               	movq	%rbx, %rax
               	shlq	$0x20, %rax
               	movq	%rax, %rsi
               	orq	$0x9, %rsi
               	callq	<addr>
               	cmpq	$0x5, %rax
               	jne	<addr>
               	movl	-0x298(%rbp), %eax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x270(%rbp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	movl	-0x270(%rbp), %eax
               	andq	$0x7, %rax
               	cmpl	$0x5, %eax
               	jne	<addr>
               	movl	-0x270(%rbp), %eax
               	sarq	$0x3, %rax
               	andq	$0x1f, %rax
               	cmpl	$0x11, %eax
               	jne	<addr>
               	movl	-0x270(%rbp), %eax
               	sarq	$0x8, %rax
               	andq	$0xfff, %rax            # imm = 0xFFF
               	movq	%rbx, %rcx
               	andq	$0xfff, %rcx            # imm = 0xFFF
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movq	-0x268(%rbp), %rax
               	cmpq	%rbx, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x260(%rbp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	movsbq	-0x260(%rbp), %rax
               	movsbq	%bl, %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movq	-0x258(%rbp), %rax
               	leaq	(%rbx,%rbx,2), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x1d0(%rbp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movq	0x10(%rax), %r10
               	movq	%r10, 0x10(%rdi)
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	0x2a(%rbx), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	$0x3, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	-0x3(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x2, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	0x78(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x250(%rbp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	movq	%rbx, %rcx
               	shlq	%rcx
               	incq	%rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	-0x250(%rbp), %rax
               	cmpq	%rbx, %rax
               	jne	<addr>
               	movq	-0x248(%rbp), %rax
               	leaq	0x1(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x240(%rbp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	(%rbx,%rbx,2), %rcx
               	subq	$0x3, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x230(%rbp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	(%rbx,%rbx,2), %rcx
               	addq	$0x4, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	-0x230(%rbp), %rax
               	cmpq	%rbx, %rax
               	jne	<addr>
               	movq	-0x228(%rbp), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, -0x28(%rbp)
               	movq	%rdx, -0x20(%rbp)
               	cmpq	%rbx, %rax
               	jne	<addr>
               	cmpq	$0x9, %rdx
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x18(%rbp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	movq	-0x18(%rbp), %rax
               	movq	-0x10(%rbp), %rcx
               	movq	-0x8(%rbp), %rdx
               	cmpq	%rbx, %rax
               	jne	<addr>
               	cmpq	$0x1, %rcx
               	jne	<addr>
               	leaq	0x2(%rbx), %rax
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0x12, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	0x7(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x220(%rbp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	0x5(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x290(%rbp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	movq	%rbx, %rcx
               	shlq	%rcx
               	addq	$0x4, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	imulq	$0x0, %rbx, %rax
               	movq	%rax, -0x198(%rbp)
               	movq	%rbx, -0x190(%rbp)
               	movq	%rbx, %rax
               	shlq	%rax
               	movq	%rax, -0x188(%rbp)
               	leaq	(%rbx,%rbx,2), %rax
               	movq	%rax, -0x180(%rbp)
               	movq	%rbx, %rax
               	shlq	$0x2, %rax
               	movq	%rax, -0x178(%rbp)
               	leaq	(%rbx,%rbx,4), %rax
               	movq	%rax, -0x170(%rbp)
               	imulq	$0x6, %rbx, %rax
               	movq	%rax, -0x168(%rbp)
               	imulq	$0x7, %rbx, %rax
               	movq	%rax, -0x160(%rbp)
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	movq	%rax, -0x158(%rbp)
               	leaq	(%rbx,%rbx,8), %rax
               	movq	%rax, -0x150(%rbp)
               	imulq	$0xa, %rbx, %rax
               	movq	%rax, -0x148(%rbp)
               	imulq	$0xb, %rbx, %rax
               	movq	%rax, -0x140(%rbp)
               	leaq	-0x198(%rbp), %rsi
               	imulq	$0xc, %rbx, %rax
               	movq	%rax, -0x138(%rbp)
               	imulq	$0xd, %rbx, %rax
               	movq	%rax, -0x130(%rbp)
               	imulq	$0xe, %rbx, %rax
               	movq	%rax, -0x128(%rbp)
               	imulq	$0xf, %rbx, %rax
               	movq	%rax, -0x120(%rbp)
               	leaq	-0x118(%rbp), %rdi
               	movl	$0x5, %edx
               	callq	<addr>
               	imulq	$0xf, %rbx, %rcx
               	addq	$0x5, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	-0x108(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	%rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x210(%rbp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	movq	-0x210(%rbp), %rax
               	cmpq	%rbx, %rax
               	jne	<addr>
               	movq	-0x208(%rbp), %rax
               	leaq	0x5(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x98(%rbp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	movq	-0x98(%rbp), %rax
               	cmpq	%rbx, %rax
               	jne	<addr>
               	cmpq	$0x0, -0x60(%rbp)
               	jne	<addr>
               	movq	-0x20(%rbp), %rax
               	leaq	0x1(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x200(%rbp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	movsd	-0x200(%rbp), %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rbx, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	-0x1f8(%rbp), %xmm0
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x19, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x1f0(%rbp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	movq	-0x1f0(%rbp), %rax
               	cmpq	%rbx, %rax
               	jne	<addr>
               	movq	-0x1e8(%rbp), %rax
               	leaq	0x2(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x1a, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x1e0(%rbp), %rdi
               	movl	$0x6, %edx
               	movq	%rbx, %rsi
               	callq	<addr>
               	movq	-0x1e0(%rbp), %rax
               	cmpq	%rbx, %rax
               	jne	<addr>
               	movq	-0x1d8(%rbp), %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x1b, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	%rbx, %rax
               	andq	$0xff, %rax
               	leaq	0x1(%rbx), %rcx
               	shlq	$0x8, %rcx
               	andq	$0xff00, %rcx           # imm = 0xFF00
               	orq	%rcx, %rax
               	movq	%rax, %r12
               	orq	$0x10000, %r12          # imm = 0x10000
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpl	%r12d, %eax
               	je	<addr>
               	movl	$0x1c, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
