
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
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
               	movq	%rsi, (%rax)
               	movl	$0x5, (%rax)
               	movq	(%rax), %r10
               	movq	%r10, (%rdi)
               	movq	(%rax), %rax
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
               	movq	%rdi, (%rax)
               	movq	%rsi, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	leaq	-0x20(%rbp), %rcx
               	leaq	0x10(%rcx), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movl	$0x1, %eax
               	movq	%rax, 0x10(%rcx)
               	movq	(%rcx), %rdx
               	imulq	$0xa, %rdx, %rdx
               	movq	0x8(%rcx), %rcx
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
               	movq	$0x0, (%rax)
               	movq	$0x0, 0x8(%rax)
               	movq	%rsi, (%rax)
               	leaq	0x1(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
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
               	movq	%rsi, (%rdi)
               	movq	%rsi, %rax
               	shlq	%rax
               	movq	%rax, 0x8(%rdi)
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rbx)
               	callq	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	movq	(%rbx), %rcx
               	addq	%rcx, %rax
               	movq	0x8(%rbx), %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	leave
               	retq

<take>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	%rsi, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	movq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	leave
               	retq

<by_value_arg>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %rax
               	leaq	-0x10(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rsi, (%rdi)
               	movq	$0x4, 0x8(%rdi)
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	leave
               	retq

<make_pair>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdi, (%rax)
               	movq	$0x9, 0x8(%rax)
               	movq	%rax, %rcx
               	movq	(%rcx), %rax
               	movq	0x8(%rcx), %rdx
               	leave
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
               	leaq	<rip>, %rdi
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
               	leaq	<rip>, %rdi
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
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq

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
               	leaq	-0x10(%rbp), %rsp
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
               	movq	%rdx, 0x18(%rax)
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
               	leaq	-0x8(%rbp), %rax
               	movq	%rdi, %rcx
               	andq	$0xff, %rcx
               	movl	%ecx, (%rax)
               	leaq	0x1(%rdi), %rcx
               	movl	(%rax), %edx
               	movl	$0xffff00ff, %r11d      # imm = 0xFFFF00FF
               	andq	%r11, %rdx
               	shlq	$0x8, %rcx
               	andq	$0xff00, %rcx           # imm = 0xFF00
               	orq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	movl	(%rax), %ecx
               	movl	$0xfffeffff, %r11d      # imm = 0xFFFEFFFF
               	andq	%r11, %rcx
               	orq	$0x10000, %rcx          # imm = 0x10000
               	movl	%ecx, (%rax)
               	movl	-0x8(%rbp), %eax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x2b8, %rsp            # imm = 0x2B8
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movq	(%rax), %rbx
               	leaq	-0x298(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rbx, (%rdi)
               	leaq	0x1(%rbx), %rax
               	movq	%rax, 0x8(%rdi)
               	callq	<addr>
               	movq	%rbx, %rcx
               	shlq	%rcx
               	incq	%rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x298(%rbp), %rdi
               	callq	<addr>
               	movq	%rbx, %rcx
               	shlq	%rcx
               	incq	%rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
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
               	leave
               	retq
               	leaq	-0x288(%rbp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	-0x288(%rbp), %rax
               	movq	(%rax), %rcx
               	cmpq	%rbx, %rcx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x298(%rbp), %rdi
               	movq	0x8(%rdi), %rsi
               	movq	(%rdi), %rdi
               	callq	<addr>
               	movq	%rax, -0x2a8(%rbp)
               	movq	%rdx, -0x2a0(%rbp)
               	leaq	-0x2a8(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	leaq	0x1(%rbx), %rax
               	cmpq	%rax, %rcx
               	jne	<addr>
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x278(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movl	%ebx, (%rdi)
               	movq	$0x2, 0x8(%rdi)
               	movq	$0x3, 0x10(%rdi)
               	movb	$0x78, 0x18(%rdi)
               	callq	<addr>
               	leaq	0x7a(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rbx, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x258(%rbp), %rdi
               	movq	%rbx, %rax
               	shlq	$0x20, %rax
               	movq	%rax, %rsi
               	orq	$0x9, %rsi
               	callq	<addr>
               	cmpq	$0x5, %rax
               	jne	<addr>
               	movslq	-0x258(%rbp), %rax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x250(%rbp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	-0x250(%rbp), %rax
               	movl	(%rax), %ecx
               	andq	$0x7, %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movl	(%rax), %ecx
               	sarq	$0x3, %rcx
               	andq	$0x1f, %rcx
               	cmpl	$0x11, %ecx
               	jne	<addr>
               	movl	(%rax), %ecx
               	sarq	$0x8, %rcx
               	andq	$0xfff, %rcx            # imm = 0xFFF
               	movq	%rbx, %rdx
               	andq	$0xfff, %rdx            # imm = 0xFFF
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	cmpq	%rbx, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x240(%rbp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	-0x240(%rbp), %rax
               	movsbq	(%rax), %rcx
               	movsbq	%bl, %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	leaq	(%rbx,%rbx,2), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x230(%rbp), %rdi
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
               	leave
               	retq
               	leaq	-0x218(%rbp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	movq	%rbx, %rcx
               	shlq	%rcx
               	incq	%rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	leaq	-0x218(%rbp), %rax
               	movq	(%rax), %rcx
               	cmpq	%rbx, %rcx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	leaq	0x1(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x208(%rbp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	(%rbx,%rbx,2), %rcx
               	subq	$0x3, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x1f8(%rbp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	(%rbx,%rbx,2), %rcx
               	addq	$0x4, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	leaq	-0x1f8(%rbp), %rax
               	movq	(%rax), %rcx
               	cmpq	%rbx, %rcx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, -0x2a8(%rbp)
               	movq	%rdx, -0x2a0(%rbp)
               	leaq	-0x2a8(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	cmpq	%rbx, %rcx
               	jne	<addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x18(%rbp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	-0x18(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	movq	0x10(%rax), %rax
               	cmpq	%rbx, %rcx
               	jne	<addr>
               	cmpq	$0x1, %rdx
               	jne	<addr>
               	leaq	0x2(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	0x7(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x1e8(%rbp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	0x5(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x298(%rbp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	movq	%rbx, %rcx
               	shlq	%rcx
               	addq	$0x4, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x1d8(%rbp), %rax
               	imulq	$0x0, %rbx, %rcx
               	movq	%rcx, (%rax)
               	movq	%rbx, 0x8(%rax)
               	movq	%rbx, %rcx
               	shlq	%rcx
               	movq	%rcx, 0x10(%rax)
               	leaq	(%rbx,%rbx,2), %rcx
               	movq	%rcx, 0x18(%rax)
               	movq	%rbx, %rcx
               	shlq	$0x2, %rcx
               	movq	%rcx, 0x20(%rax)
               	leaq	(%rbx,%rbx,4), %rcx
               	movq	%rcx, 0x28(%rax)
               	leaq	-0x1d8(%rbp), %rax
               	imulq	$0x6, %rbx, %rcx
               	movq	%rcx, 0x30(%rax)
               	imulq	$0x7, %rbx, %rcx
               	movq	%rcx, 0x38(%rax)
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	movq	%rcx, 0x40(%rax)
               	leaq	(%rbx,%rbx,8), %rcx
               	movq	%rcx, 0x48(%rax)
               	imulq	$0xa, %rbx, %rcx
               	movq	%rcx, 0x50(%rax)
               	imulq	$0xb, %rbx, %rcx
               	movq	%rcx, 0x58(%rax)
               	leaq	-0x1d8(%rbp), %rsi
               	imulq	$0xc, %rbx, %rax
               	movq	%rax, 0x60(%rsi)
               	imulq	$0xd, %rbx, %rax
               	movq	%rax, 0x68(%rsi)
               	imulq	$0xe, %rbx, %rax
               	movq	%rax, 0x70(%rsi)
               	imulq	$0xf, %rbx, %rax
               	movq	%rax, 0x78(%rsi)
               	leaq	-0x158(%rbp), %rdi
               	movl	$0x5, %edx
               	callq	<addr>
               	imulq	$0xf, %rbx, %rcx
               	addq	$0x5, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	leaq	-0x158(%rbp), %rax
               	movq	0x10(%rax), %rax
               	movq	%rbx, %rcx
               	shlq	%rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xd8(%rbp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	-0xd8(%rbp), %rax
               	movq	(%rax), %rcx
               	cmpq	%rbx, %rcx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	leaq	0x5(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0xc8(%rbp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	-0xc8(%rbp), %rax
               	movq	(%rax), %rcx
               	cmpq	%rbx, %rcx
               	jne	<addr>
               	cmpq	$0x0, 0x38(%rax)
               	jne	<addr>
               	movq	0x78(%rax), %rax
               	leaq	0x1(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x48(%rbp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	-0x48(%rbp), %rax
               	movsd	(%rax), %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rbx, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	0x8(%rax), %xmm0
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x19, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x38(%rbp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	-0x38(%rbp), %rax
               	movq	(%rax), %rcx
               	cmpq	%rbx, %rcx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	leaq	0x2(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x1a, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x28(%rbp), %rdi
               	movl	$0x6, %edx
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	-0x28(%rbp), %rax
               	movq	(%rax), %rcx
               	cmpq	%rbx, %rcx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x1b, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	%ebx, %edi
               	movq	%rbx, %rax
               	andq	$0xff, %rax
               	leaq	0x1(%rdi), %rcx
               	shlq	$0x8, %rcx
               	andq	$0xff00, %rcx           # imm = 0xFF00
               	orq	%rcx, %rax
               	movq	%rax, %rbx
               	orq	$0x10000, %rbx          # imm = 0x10000
               	callq	<addr>
               	cmpl	%ebx, %eax
               	je	<addr>
               	movl	$0x1c, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xb, %eax
               	popq	%rbx
               	leave
               	retq
