
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
               	leaq	-0x420(%rbp), %rax
               	movl	$0x64, (%rax)
               	movl	$0xc8, 0x4(%rax)
               	movl	$0x12c, 0x8(%rax)       # imm = 0x12C
               	movl	$0x190, 0xc(%rax)       # imm = 0x190
               	movl	$0xffffffff, 0xb0(%rax) # imm = 0xFFFFFFFF
               	movl	$0xfffffffe, 0x154(%rax) # imm = 0xFFFFFFFE
               	movl	$0xfffffffd, 0x1f8(%rax) # imm = 0xFFFFFFFD
               	leaq	-0x420(%rbp), %rcx
               	movl	$0x1f4, 0x1fc(%rcx)     # imm = 0x1F4
               	movl	$0x258, 0x200(%rcx)     # imm = 0x258
               	movl	$0x2bc, 0x204(%rcx)     # imm = 0x2BC
               	movl	$0x320, 0x208(%rcx)     # imm = 0x320
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
               	movq	%rax, %r11
               	leaq	0x200(%rcx), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%r11)
               	addq	$0x10, %rcx
               	addq	$0x10, %r11
               	cmpq	%rdi, %rcx
               	jne	<addr>
               	movq	(%rcx), %r10
               	movq	%r10, (%r11)
               	movl	0x8(%rcx), %r10d
               	movl	%r10d, 0x8(%r11)
               	movslq	(%rax), %rcx
               	cmpl	$0x64, %ecx
               	jne	<addr>
               	movslq	0x4(%rax), %rcx
               	cmpl	$0xc8, %ecx
               	jne	<addr>
               	movslq	0x8(%rax), %rcx
               	cmpl	$0x12c, %ecx            # imm = 0x12C
               	jne	<addr>
               	movslq	0xc(%rax), %rcx
               	cmpl	$0x190, %ecx            # imm = 0x190
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movslq	0x1fc(%rax), %rcx
               	cmpl	$0x1f4, %ecx            # imm = 0x1F4
               	jne	<addr>
               	movslq	0x200(%rax), %rax
               	cmpl	$0x258, %eax            # imm = 0x258
               	jne	<addr>
               	leaq	-0x210(%rbp), %rcx
               	movslq	0x204(%rcx), %rax
               	cmpl	$0x2bc, %eax            # imm = 0x2BC
               	jne	<addr>
               	movslq	0x208(%rcx), %rax
               	cmpl	$0x320, %eax            # imm = 0x320
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movslq	0xb0(%rcx), %rax
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movslq	0x154(%rcx), %rax
               	cmpl	$-0x2, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movslq	0x1f8(%rcx), %rax
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leaq	0x10(%rcx), %rdx
               	movslq	(%rdx,%rax,4), %rdx
               	leaq	0x3e8(%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	leaq	0xb4(%rcx), %rdx
               	movslq	(%rdx,%rax,4), %rdx
               	leaq	0x7d0(%rax), %rsi
               	cmpl	%esi, %edx
               	jne	<addr>
               	leaq	0x158(%rcx), %rdx
               	movslq	(%rdx,%rax,4), %rdx
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
