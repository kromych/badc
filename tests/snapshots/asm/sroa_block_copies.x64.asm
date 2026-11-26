
sroa_block_copies.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	movabsq	$-0x100000000, %rax     # imm = 0xFFFFFFFF00000000
               	andq	%rsi, %rax
               	orq	$0x5, %rax
               	movq	%rax, (%rdi)
               	movl	%eax, %eax
               	retq

<bitfield_copy>:
               	movq	%rsi, %rax
               	andq	$0xfff, %rax            # imm = 0xFFF
               	shlq	$0x8, %rax
               	orq	$0x8d, %rax
               	movq	%rax, (%rdi)
               	movq	%rsi, 0x8(%rdi)
               	retq

<padded_copy>:
               	movsbq	%sil, %rax
               	leaq	(%rsi,%rsi,2), %rcx
               	andq	$0xff, %rax
               	movq	%rax, (%rdi)
               	movq	%rcx, 0x8(%rdi)
               	retq

<fam_copy>:
               	movq	%rsi, (%rdi)
               	movq	0x8(%rdi), %rax
               	addq	%rsi, %rax
               	retq

<self_assign>:
               	subq	%rsi, %rdi
               	movq	%rdi, %rax
               	retq

<member_copy>:
               	subq	$0x28, %rsp
               	leaq	(%rsp), %rax
               	movq	%rdi, (%rsp)
               	movq	%rsi, 0x8(%rsp)
               	movq	%rsi, 0x10(%rsp)
               	movq	%rdi, 0x18(%rsp)
               	leaq	0x10(%rax), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	$0x1, 0x10(%rsp)
               	movq	(%rsp), %rax
               	imulq	$0xa, %rax, %rax
               	movq	0x8(%rsp), %rcx
               	addq	%rcx, %rax
               	addq	$0x64, %rax
               	addq	$0x28, %rsp
               	retq

<volatile_copy>:
               	subq	$0x18, %rsp
               	movq	%rsi, (%rsp)
               	leaq	0x1(%rsi), %rax
               	movq	%rax, 0x8(%rsp)
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	(%rsp), %rdx
               	movq	%rdx, (%rdi)
               	movq	0x8(%rsp), %rdx
               	movq	%rdx, 0x8(%rdi)
               	addq	%rcx, %rax
               	addq	$0x18, %rsp
               	retq

<clobber>:
               	movq	$-0x1, (%rdi)
               	movq	$-0x2, 0x8(%rdi)
               	retq

<escape_after_copy>:
               	subq	$0x20, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	leaq	0x10(%rsp), %rdi
               	movq	%rsi, 0x10(%rsp)
               	shlq	%rsi
               	movq	%rsi, 0x18(%rsp)
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rbx)
               	callq	<addr>
               	movq	0x10(%rsp), %rax
               	movq	0x18(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	(%rbx), %rcx
               	addq	%rcx, %rax
               	movq	0x8(%rbx), %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq

<take>:
               	leaq	(%rdi,%rdi,2), %rax
               	addq	%rsi, %rax
               	retq

<by_value_arg>:
               	pushq	%rax
               	movl	$0x4, %eax
               	movq	%rsi, (%rdi)
               	movq	%rax, 0x8(%rdi)
               	movq	%rsi, %rdi
               	movq	%rax, %rsi
               	callq	<addr>
               	popq	%r11
               	retq

<make_pair>:
               	movq	%rdi, %rax
               	movl	$0x9, %edx
               	retq

<make_large>:
               	subq	$0x18, %rsp
               	movq	%rdi, (%rsp)
               	leaq	0x2(%rsi), %rcx
               	movq	(%rsp), %rax
               	movq	%rsi, (%rax)
               	movq	$0x1, 0x8(%rax)
               	movq	%rcx, 0x10(%rax)
               	addq	$0x18, %rsp
               	retq

<large_return_inlined>:
               	leaq	0x3(%rdi), %rax
               	addq	$0x4, %rax
               	retq

<jump_back>:
               	pushq	%rax
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x1, %esi
               	callq	<addr>
               	ud2

<copy_across_setjmp>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	leaq	<rip>, %rdi # <addr>
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
               	movb	$0x3, (%rax,%rcx)
               	movq	(%rdi), %rax
               	movq	0x8(%rdi), %rcx
               	addq	$0x3, %rcx
               	addq	%rcx, %rax
               	leave
               	retq

<big_copy>:
               	subq	$0x88, %rsp
               	leaq	(%rsp), %rax
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
               	movq	%rdx, 0x18(%rsp)
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
               	addq	$0x88, %rsp
               	retq

<array_member_copy>:
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
               	movsd	<rip>, %xmm1
               	movsd	%xmm0, (%rdi)
               	movsd	%xmm1, 0x8(%rdi)
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
               	movq	%rdi, %rax
               	andq	$0xff, %rax
               	leaq	0x1(%rdi), %rcx
               	shlq	$0x8, %rcx
               	andq	$0xff00, %rcx           # imm = 0xFF00
               	orq	%rcx, %rax
               	orq	$0x10000, %rax          # imm = 0x10000
               	retq

<main>:
               	subq	$0x2a0, %rsp            # imm = 0x2A0
               	pushq	%rbx
               	movq	<rip>, %rbx # <addr>
               	movq	%rbx, 0x28(%rsp)
               	leaq	0x1(%rbx), %rax
               	movq	%rax, 0x30(%rsp)
               	leaq	0x28(%rsp), %rdi
               	callq	<addr>
               	movq	%rbx, %rcx
               	shlq	%rcx
               	incq	%rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	retq
               	leaq	0x28(%rsp), %rdi
               	callq	<addr>
               	movq	%rbx, %rcx
               	shlq	%rcx
               	incq	%rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	retq
               	movq	%rbx, %rdi
               	movl	$0x4, %esi
               	callq	<addr>
               	leaq	0x4(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	retq
               	movq	%rbx, %rsi
               	leaq	0x38(%rsp), %rdi
               	callq	<addr>
               	movq	0x38(%rsp), %rax
               	cmpq	%rbx, %rax
               	jne	<addr>
               	movq	0x40(%rsp), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	retq
               	movq	0x28(%rsp), %rdi
               	movq	0x30(%rsp), %rsi
               	callq	<addr>
               	leaq	0x1(%rbx), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	cmpq	%rcx, %rdx
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	retq
               	leaq	0x100(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movl	%ebx, 0x100(%rsp)
               	movq	$0x2, 0x108(%rsp)
               	movq	$0x3, 0x110(%rsp)
               	movb	$0x78, 0x118(%rsp)
               	callq	<addr>
               	leaq	0x7a(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rbx, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	retq
               	movq	%rbx, %rsi
               	shlq	$0x20, %rsi
               	orq	$0x9, %rsi
               	leaq	0x20(%rsp), %rdi
               	callq	<addr>
               	cmpq	$0x5, %rax
               	jne	<addr>
               	movl	0x20(%rsp), %eax
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	retq
               	movq	%rbx, %rsi
               	leaq	0x48(%rsp), %rdi
               	callq	<addr>
               	movl	0x48(%rsp), %eax
               	movq	%rax, %rcx
               	andq	$0x7, %rcx
               	cmpl	$0x5, %ecx
               	jne	<addr>
               	movq	%rax, %rcx
               	sarq	$0x3, %rcx
               	andq	$0x1f, %rcx
               	cmpl	$0x11, %ecx
               	jne	<addr>
               	sarq	$0x8, %rax
               	andq	$0xfff, %rax            # imm = 0xFFF
               	movq	%rbx, %rcx
               	andq	$0xfff, %rcx            # imm = 0xFFF
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movq	0x50(%rsp), %rax
               	cmpq	%rbx, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	retq
               	movq	%rbx, %rsi
               	leaq	0x58(%rsp), %rdi
               	callq	<addr>
               	movsbq	0x58(%rsp), %rax
               	movsbq	%bl, %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movq	0x60(%rsp), %rax
               	leaq	(%rbx,%rbx,2), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	retq
               	leaq	0xe8(%rsp), %rdi
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
               	movq	%rbx, %rdi
               	movl	$0x3, %esi
               	callq	<addr>
               	leaq	-0x3(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	retq
               	movq	%rbx, %rdi
               	movl	$0x2, %esi
               	callq	<addr>
               	leaq	0x78(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	retq
               	movq	%rbx, %rsi
               	leaq	0x68(%rsp), %rdi
               	callq	<addr>
               	movq	%rbx, %rcx
               	shlq	%rcx
               	incq	%rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	0x68(%rsp), %rax
               	cmpq	%rbx, %rax
               	jne	<addr>
               	movq	0x70(%rsp), %rax
               	leaq	0x1(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	retq
               	movq	%rbx, %rsi
               	leaq	0x78(%rsp), %rdi
               	callq	<addr>
               	leaq	(%rbx,%rbx,2), %rcx
               	subq	$0x3, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	retq
               	movq	%rbx, %rsi
               	leaq	0x88(%rsp), %rdi
               	callq	<addr>
               	leaq	(%rbx,%rbx,2), %rcx
               	addq	$0x4, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	0x88(%rsp), %rax
               	cmpq	%rbx, %rax
               	jne	<addr>
               	movq	0x90(%rsp), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	%rbx, %rax
               	jne	<addr>
               	cmpq	$0x9, %rdx
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	retq
               	movq	%rbx, %rsi
               	leaq	0x288(%rsp), %rdi
               	callq	<addr>
               	movq	0x288(%rsp), %rax
               	movq	0x290(%rsp), %rcx
               	movq	0x298(%rsp), %rdx
               	cmpq	%rbx, %rax
               	jne	<addr>
               	cmpq	$0x1, %rcx
               	jne	<addr>
               	leaq	0x2(%rbx), %rax
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0x12, %eax
               	popq	%rbx
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	0x7(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	popq	%rbx
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	retq
               	movq	%rbx, %rsi
               	leaq	0x98(%rsp), %rdi
               	callq	<addr>
               	leaq	0x5(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	popq	%rbx
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	retq
               	movq	%rbx, %rsi
               	leaq	0x28(%rsp), %rdi
               	callq	<addr>
               	movq	%rbx, %rcx
               	shlq	%rcx
               	addq	$0x4, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	popq	%rbx
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	retq
               	movq	$0x0, 0x120(%rsp)
               	movq	%rbx, 0x128(%rsp)
               	movq	%rbx, %rax
               	shlq	%rax
               	movq	%rax, 0x130(%rsp)
               	leaq	(%rbx,%rbx,2), %rax
               	movq	%rax, 0x138(%rsp)
               	movq	%rbx, %rax
               	shlq	$0x2, %rax
               	movq	%rax, 0x140(%rsp)
               	leaq	(%rbx,%rbx,4), %rax
               	movq	%rax, 0x148(%rsp)
               	imulq	$0x6, %rbx, %rax
               	movq	%rax, 0x150(%rsp)
               	imulq	$0x7, %rbx, %rax
               	movq	%rax, 0x158(%rsp)
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	movq	%rax, 0x160(%rsp)
               	leaq	(%rbx,%rbx,8), %rax
               	movq	%rax, 0x168(%rsp)
               	imulq	$0xa, %rbx, %rax
               	movq	%rax, 0x170(%rsp)
               	imulq	$0xb, %rbx, %rax
               	movq	%rax, 0x178(%rsp)
               	imulq	$0xc, %rbx, %rax
               	movq	%rax, 0x180(%rsp)
               	imulq	$0xd, %rbx, %rax
               	movq	%rax, 0x188(%rsp)
               	imulq	$0xe, %rbx, %rax
               	movq	%rax, 0x190(%rsp)
               	imulq	$0xf, %rbx, %rax
               	movq	%rax, 0x198(%rsp)
               	leaq	0x1a0(%rsp), %rdi
               	leaq	0x120(%rsp), %rsi
               	movl	$0x5, %edx
               	callq	<addr>
               	imulq	$0xf, %rbx, %rcx
               	addq	$0x5, %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movq	0x1b0(%rsp), %rax
               	movq	%rbx, %rcx
               	shlq	%rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	popq	%rbx
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	retq
               	movq	%rbx, %rsi
               	leaq	0xa8(%rsp), %rdi
               	callq	<addr>
               	movq	0xa8(%rsp), %rax
               	cmpq	%rbx, %rax
               	jne	<addr>
               	movq	0xb0(%rsp), %rax
               	leaq	0x5(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	popq	%rbx
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	retq
               	movq	%rbx, %rsi
               	leaq	0x220(%rsp), %rdi
               	callq	<addr>
               	movq	0x220(%rsp), %rax
               	cmpq	%rbx, %rax
               	jne	<addr>
               	cmpq	$0x0, 0x258(%rsp)
               	jne	<addr>
               	movq	0x298(%rsp), %rax
               	leaq	0x1(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	popq	%rbx
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	retq
               	movq	%rbx, %rsi
               	leaq	0xb8(%rsp), %rdi
               	callq	<addr>
               	movsd	0xb8(%rsp), %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rbx, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movsd	0xc0(%rsp), %xmm0
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x19, %eax
               	popq	%rbx
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	retq
               	movq	%rbx, %rsi
               	leaq	0xc8(%rsp), %rdi
               	callq	<addr>
               	movq	0xc8(%rsp), %rax
               	cmpq	%rbx, %rax
               	jne	<addr>
               	movq	0xd0(%rsp), %rax
               	leaq	0x2(%rbx), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x1a, %eax
               	popq	%rbx
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	retq
               	movq	%rbx, %rsi
               	leaq	0xd8(%rsp), %rdi
               	movl	$0x6, %edx
               	callq	<addr>
               	movq	0xd8(%rsp), %rax
               	cmpq	%rbx, %rax
               	jne	<addr>
               	movq	0xe0(%rsp), %rax
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x1b, %eax
               	popq	%rbx
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	retq
               	movq	%rbx, %rcx
               	andq	$0xff, %rcx
               	leaq	0x1(%rbx), %rax
               	shlq	$0x8, %rax
               	andq	$0xff00, %rax           # imm = 0xFF00
               	orq	%rax, %rcx
               	movq	%rcx, %r10
               	orq	$0x10000, %r10          # imm = 0x10000
               	movq	%r10, 0x18(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpl	0x18(%rsp), %eax
               	je	<addr>
               	movl	$0x1c, %eax
               	popq	%rbx
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	retq
               	movl	$0xb, %eax
               	popq	%rbx
               	addq	$0x2a0, %rsp            # imm = 0x2A0
               	retq
