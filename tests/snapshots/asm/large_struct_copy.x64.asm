
large_struct_copy.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x420, %rsp            # imm = 0x420
               	movl	$0x64, -0x420(%rbp)
               	movl	$0xc8, -0x41c(%rbp)
               	movl	$0x12c, -0x418(%rbp)    # imm = 0x12C
               	movl	$0x190, -0x414(%rbp)    # imm = 0x190
               	movl	$0xffffffff, -0x370(%rbp) # imm = 0xFFFFFFFF
               	movl	$0xfffffffe, -0x2cc(%rbp) # imm = 0xFFFFFFFE
               	movl	$0xfffffffd, -0x228(%rbp) # imm = 0xFFFFFFFD
               	leaq	-0x420(%rbp), %rcx
               	movl	$0x1f4, -0x224(%rbp)    # imm = 0x1F4
               	movl	$0x258, -0x220(%rbp)    # imm = 0x258
               	movl	$0x2bc, -0x21c(%rbp)    # imm = 0x2BC
               	movl	$0x320, -0x218(%rbp)    # imm = 0x320
               	xorl	%eax, %eax
               	leaq	0x10(%rcx), %rdx
               	leaq	0x3e8(%rax), %rsi
               	movl	%esi, (%rdx,%rax,4)
               	leaq	0xb4(%rcx), %rdx
               	leaq	0x7d0(%rax), %rsi
               	movl	%esi, (%rdx,%rax,4)
               	leaq	0x158(%rcx), %rdx
               	leaq	0xbb8(%rax), %rsi
               	movl	%esi, (%rdx,%rax,4)
               	incq	%rax
               	cmpl	$0x28, %eax
               	jl	<addr>
               	leaq	-0x210(%rbp), %rdi
               	movl	$0x7e, %esi
               	movl	$0x20c, %edx            # imm = 0x20C
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x210(%rbp), %rax
               	leaq	-0x420(%rbp), %rcx
               	leaq	0x200(%rcx), %r11
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	addq	$0x10, %rcx
               	addq	$0x10, %rax
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movl	0x8(%rcx), %r10d
               	movl	%r10d, 0x8(%rax)
               	movl	-0x210(%rbp), %eax
               	cmpl	$0x64, %eax
               	jne	<addr>
               	movl	-0x20c(%rbp), %eax
               	cmpl	$0xc8, %eax
               	jne	<addr>
               	movl	-0x208(%rbp), %eax
               	cmpl	$0x12c, %eax            # imm = 0x12C
               	jne	<addr>
               	movl	-0x204(%rbp), %eax
               	cmpl	$0x190, %eax            # imm = 0x190
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	-0x14(%rbp), %eax
               	cmpl	$0x1f4, %eax            # imm = 0x1F4
               	jne	<addr>
               	movl	-0x10(%rbp), %eax
               	cmpl	$0x258, %eax            # imm = 0x258
               	jne	<addr>
               	leaq	-0x210(%rbp), %rcx
               	movl	-0xc(%rbp), %eax
               	cmpl	$0x2bc, %eax            # imm = 0x2BC
               	jne	<addr>
               	movl	-0x8(%rbp), %eax
               	cmpl	$0x320, %eax            # imm = 0x320
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	-0x160(%rbp), %eax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movl	-0xbc(%rbp), %eax
               	cmpl	$-0x2, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	-0x18(%rbp), %eax
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	0x10(%rcx), %rdx
               	movl	(%rdx,%rax,4), %edx
               	leaq	0x3e8(%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	leaq	0xb4(%rcx), %rdx
               	movl	(%rdx,%rax,4), %edx
               	leaq	0x7d0(%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	leaq	0x158(%rcx), %rdx
               	movl	(%rdx,%rax,4), %edx
               	leaq	0xbb8(%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x28, %eax
               	jl	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	leave
               	retq
               	addq	$0x6e, %rax
               	leave
               	retq
               	addq	$0x3c, %rax
               	leave
               	retq
               	addq	$0xa, %rax
               	leave
               	retq
