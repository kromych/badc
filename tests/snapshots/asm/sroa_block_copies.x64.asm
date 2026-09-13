
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
               	movl	$0x7, %eax
               	movq	%rsi, (%rdi)
               	movq	%rax, 0x8(%rdi)
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
               	movl	$0x5, %ecx
               	movl	%ecx, (%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	popq	%rcx
               	movq	(%rax), %rax
               	movl	%eax, %eax
               	leave
               	retq

<bitfield_copy>:
               	xorq	%rax, %rax
               	movq	%rsi, %rcx
               	andq	$0xfff, %rcx            # imm = 0xFFF
               	shlq	$0x8, %rcx
               	orq	$0x8d, %rcx
               	movl	%ecx, %ecx
               	movl	%ecx, (%rdi)
               	movl	%eax, 0x4(%rdi)
               	movq	%rsi, 0x8(%rdi)
               	retq

<padded_copy>:
               	xorq	%rax, %rax
               	movsbq	%sil, %rcx
               	leaq	(%rsi,%rsi,2), %rdx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdi)
               	movb	%al, 0x1(%rdi)
               	movw	%ax, 0x2(%rdi)
               	movl	%eax, 0x4(%rdi)
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
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
               	movl	$0x1, %eax
               	movq	%rax, 0x10(%rcx)
               	movq	(%rcx), %rdx
               	imulq	$0xa, %rdx, %rdx
               	movq	0x8(%rcx), %rsi
               	addq	%rsi, %rdx
               	imulq	$0x64, %rax, %rax
               	addq	%rdx, %rax
               	leave
               	retq

<volatile_copy>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x10(%rbp), %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rax)
               	leaq	0x8(%rax), %rcx
               	movq	%rdx, (%rcx)
               	movq	%rsi, (%rax)
               	leaq	0x1(%rsi), %rdx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rdx
               	movq	(%rcx), %rcx
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	%rsi, (%rdi)
               	addq	$0x8, %rax
               	movq	(%rax), %rax
               	movq	%rax, 0x8(%rdi)
               	leaq	(%rdx,%rcx), %rax
               	leave
               	retq

<clobber>:
               	movabsq	$-0x1, %rax
               	movq	%rax, (%rdi)
               	movabsq	$-0x2, %rax
               	movq	%rax, 0x8(%rdi)
               	retq

<escape_after_copy>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%rdi, %rbx
               	leaq	-0x10(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rsi, (%rdi)
               	movq	%rsi, %rax
               	shlq	%rax
               	movq	%rax, 0x8(%rdi)
               	pushq	%rax
               	movq	(%rdi), %rax
               	movq	%rax, (%rbx)
               	movq	0x8(%rdi), %rax
               	movq	%rax, 0x8(%rbx)
               	popq	%rax
               	callq	<addr>
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	addq	%rcx, %rax
               	movq	(%rbx), %rcx
               	addq	%rcx, %rax
               	movq	0x8(%rbx), %rcx
               	addq	%rcx, %rax
               	movq	(%rsp), %rbx
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
               	movl	$0x4, %ecx
               	movq	%rcx, 0x8(%rdi)
               	pushq	%rcx
               	movq	(%rdi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdi), %rcx
               	movq	%rcx, 0x8(%rax)
               	popq	%rcx
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
               	movl	$0x9, %ecx
               	movq	%rcx, 0x8(%rax)
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
               	movq	%rsi, -0x10(%rbp)
               	movq	-0x10(%rbp), %rcx
               	movl	$0x1, %edx
               	leaq	0x2(%rcx), %rsi
               	movq	-0x20(%rbp), %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
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
               	movzbq	%al, %rax
               	ud2

<copy_across_setjmp>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movl	$0x5, %r13d
               	leaq	<rip>, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%r12, (%rbx)
               	movq	%r13, 0x8(%rbx)
               	leaq	0x5(%r12), %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	callq	<addr>
               	movabsq	$-0x1, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq

<vla_copy>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rsi, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rax
               	subq	%r11, %rax
               	shrq	$0xc, %r11
               	testq	%r11, %r11
               	je	<addr>
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1, %r11
               	jne	<addr>
               	movq	%rax, %rsp
               	leaq	-0x1(%rsi), %rcx
               	leaq	(%rax,%rcx), %r8
               	movl	$0x3, %edx
               	movb	%dl, (%r8)
               	movq	(%rdi), %r8
               	movq	0x8(%rdi), %rdi
               	movsbq	%dl, %rax
               	addq	%rdi, %rax
               	addq	%r8, %rax
               	leaq	-0x10(%rbp), %rsp
               	leave
               	retq

<big_copy>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	leaq	-0x80(%rbp), %rax
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	movq	0x10(%rsi), %rcx
               	movq	%rcx, 0x10(%rax)
               	movq	0x18(%rsi), %rcx
               	movq	%rcx, 0x18(%rax)
               	movq	0x20(%rsi), %rcx
               	movq	%rcx, 0x20(%rax)
               	movq	0x28(%rsi), %rcx
               	movq	%rcx, 0x28(%rax)
               	movq	0x30(%rsi), %rcx
               	movq	%rcx, 0x30(%rax)
               	movq	0x38(%rsi), %rcx
               	movq	%rcx, 0x38(%rax)
               	movq	0x40(%rsi), %rcx
               	movq	%rcx, 0x40(%rax)
               	movq	0x48(%rsi), %rcx
               	movq	%rcx, 0x48(%rax)
               	movq	0x50(%rsi), %rcx
               	movq	%rcx, 0x50(%rax)
               	movq	0x58(%rsi), %rcx
               	movq	%rcx, 0x58(%rax)
               	movq	0x60(%rsi), %rcx
               	movq	%rcx, 0x60(%rax)
               	movq	0x68(%rsi), %rcx
               	movq	%rcx, 0x68(%rax)
               	movq	0x70(%rsi), %rcx
               	movq	%rcx, 0x70(%rax)
               	movq	0x78(%rsi), %rcx
               	movq	%rcx, 0x78(%rax)
               	popq	%rcx
               	movq	%rdx, 0x18(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rdi)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%rdi)
               	movq	0x20(%rax), %rcx
               	movq	%rcx, 0x20(%rdi)
               	movq	0x28(%rax), %rcx
               	movq	%rcx, 0x28(%rdi)
               	movq	0x30(%rax), %rcx
               	movq	%rcx, 0x30(%rdi)
               	movq	0x38(%rax), %rcx
               	movq	%rcx, 0x38(%rdi)
               	movq	0x40(%rax), %rcx
               	movq	%rcx, 0x40(%rdi)
               	movq	0x48(%rax), %rcx
               	movq	%rcx, 0x48(%rdi)
               	movq	0x50(%rax), %rcx
               	movq	%rcx, 0x50(%rdi)
               	movq	0x58(%rax), %rcx
               	movq	%rcx, 0x58(%rdi)
               	movq	0x60(%rax), %rcx
               	movq	%rcx, 0x60(%rdi)
               	movq	0x68(%rax), %rcx
               	movq	%rcx, 0x68(%rdi)
               	movq	0x70(%rax), %rcx
               	movq	%rcx, 0x70(%rdi)
               	movq	0x78(%rax), %rcx
               	movq	%rcx, 0x78(%rdi)
               	popq	%rcx
               	movq	0x18(%rdi), %rax
               	movq	0x78(%rdi), %rcx
               	addq	%rcx, %rax
               	leave
               	retq

<array_member_copy>:
               	leaq	0x5(%rsi), %rax
               	movq	%rsi, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	retq

<wide_copy>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	leaq	-0x80(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movups	%xmm14, 0x50(%rax)
               	movups	%xmm14, 0x60(%rax)
               	movups	%xmm14, 0x70(%rax)
               	movq	%rsi, (%rax)
               	leaq	0x1(%rsi), %rcx
               	movq	%rcx, 0x78(%rax)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rdi)
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x18(%rdi)
               	movq	0x20(%rax), %rcx
               	movq	%rcx, 0x20(%rdi)
               	movq	0x28(%rax), %rcx
               	movq	%rcx, 0x28(%rdi)
               	movq	0x30(%rax), %rcx
               	movq	%rcx, 0x30(%rdi)
               	movq	0x38(%rax), %rcx
               	movq	%rcx, 0x38(%rdi)
               	movq	0x40(%rax), %rcx
               	movq	%rcx, 0x40(%rdi)
               	movq	0x48(%rax), %rcx
               	movq	%rcx, 0x48(%rdi)
               	movq	0x50(%rax), %rcx
               	movq	%rcx, 0x50(%rdi)
               	movq	0x58(%rax), %rcx
               	movq	%rcx, 0x58(%rdi)
               	movq	0x60(%rax), %rcx
               	movq	%rcx, 0x60(%rdi)
               	movq	0x68(%rax), %rcx
               	movq	%rcx, 0x68(%rdi)
               	movq	0x70(%rax), %rcx
               	movq	%rcx, 0x70(%rdi)
               	movq	0x78(%rax), %rcx
               	movq	%rcx, 0x78(%rdi)
               	popq	%rcx
               	leave
               	retq

<fp_copy>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rsi, %xmm0
               	movsd	%xmm0, (%rax,%riz)
               	movabsq	$0x3fe0000000000000, %rcx # imm = 0x3FE0000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, 0x8(%rax,%riz)
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	popq	%rcx
               	leave
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
               	xorq	%rax, %rax
               	movl	%eax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movl	%edi, %ecx
               	movl	%ecx, %edx
               	shlq	$0x0, %rdx
               	movl	%edx, %edx
               	andq	$0xff, %rdx
               	orq	$0x0, %rdx
               	movl	%edx, (%rax)
               	incq	%rcx
               	movl	%ecx, %ecx
               	movl	(%rax), %edx
               	movl	$0xffff00ff, %r11d      # imm = 0xFFFF00FF
               	andq	%r11, %rdx
               	movl	%ecx, %ecx
               	shlq	$0x8, %rcx
               	movl	%ecx, %ecx
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
               	subq	$0x2c0, %rsp            # imm = 0x2C0
               	movq	%rbx, (%rsp)
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
               	movq	(%rsp), %rbx
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
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x4, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	0x4(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
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
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
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
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x278(%rbp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movl	%ebx, (%rdi)
               	movl	$0x2, %eax
               	movq	%rax, 0x8(%rdi)
               	movl	$0x3, %eax
               	movq	%rax, 0x10(%rdi)
               	movl	$0x78, %eax
               	movb	%al, 0x18(%rdi)
               	callq	<addr>
               	leaq	0x7a(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rbx, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
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
               	leaq	-0x258(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x5, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
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
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	(%rax), %ecx
               	sarq	$0x8, %rcx
               	andq	$0xfff, %rcx            # imm = 0xFFF
               	movq	%rbx, %rdx
               	andq	$0xfff, %rdx            # imm = 0xFFF
               	cmpl	%edx, %ecx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	cmpq	%rbx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
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
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x230(%rbp), %rdi
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdi)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdi)
               	movq	0x10(%rax), %rcx
               	movq	%rcx, 0x10(%rdi)
               	popq	%rcx
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	0x2a(%rbx), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movl	$0x3, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	-0x3(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0x2, %esi
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	0x78(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	movq	(%rsp), %rbx
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
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	leaq	0x1(%rbx), %rcx
               	cmpq	%rcx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
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
               	movq	(%rsp), %rbx
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
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	0x8(%rax), %rax
               	cmpq	$0x4, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	movq	(%rsp), %rbx
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
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x18(%rbp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	-0x18(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdx
               	movq	0x10(%rax), %rsi
               	cmpq	%rbx, %rcx
               	jne	<addr>
               	cmpq	$0x1, %rdx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x2(%rbx), %rax
               	cmpq	%rax, %rsi
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	0x7(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x1e8(%rbp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	0x5(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	movq	(%rsp), %rbx
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
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x1d8(%rbp), %rax
               	leaq	(%rax), %rcx
               	imulq	$0x0, %rbx, %rdx
               	movq	%rdx, (%rcx)
               	movq	%rbx, %rcx
               	shlq	$0x0, %rcx
               	movq	%rcx, 0x8(%rax)
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
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	movq	(%rsp), %rbx
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
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0xc8(%rbp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	-0xc8(%rbp), %rax
               	movq	(%rax), %rcx
               	cmpq	%rbx, %rcx
               	jne	<addr>
               	movq	0x38(%rax), %rcx
               	testq	%rcx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movq	0x78(%rax), %rax
               	leaq	0x1(%rbx), %rcx
               	cmpq	%rcx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	leaq	-0x48(%rbp), %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	-0x48(%rbp), %rax
               	movsd	(%rax,%riz), %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rbx, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	0x8(%rax,%riz), %xmm0
               	movabsq	$0x3fe0000000000000, %rax # imm = 0x3FE0000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x19, %eax
               	movq	(%rsp), %rbx
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
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1a, %eax
               	movq	(%rsp), %rbx
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
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1b, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	%ebx, %edi
               	movq	%rbx, %rcx
               	andq	$0xff, %rcx
               	leaq	0x1(%rdi), %rax
               	movl	%eax, %eax
               	shlq	$0x8, %rax
               	andq	$0xff00, %rax           # imm = 0xFF00
               	orq	%rcx, %rax
               	movq	%rax, %rbx
               	orq	$0x10000, %rbx          # imm = 0x10000
               	callq	<addr>
               	movl	%ebx, %ecx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x1c, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	leave
               	retq
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	leave
               	retq
