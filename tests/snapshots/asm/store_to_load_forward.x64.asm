
store_to_load_forward.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	leaq	-0x10(%rbp), %rax
               	movl	$0x3e8, %ecx            # imm = 0x3E8
               	movl	$0x7, %edx
               	movq	%rcx, (%rax)
               	movl	%edx, 0x8(%rax)
               	movl	$0x7, %esi
               	movw	%si, 0xc(%rax)
               	movl	$0x7, %edi
               	movb	%dil, 0xe(%rax)
               	movl	$0x7, %r8d
               	movb	%r8b, 0xf(%rax)
               	movslq	%edx, %rdx
               	movswq	%si, %rsi
               	movsbq	%dil, %rdi
               	movzbq	0xf(%rax), %rax
               	addq	%rdx, %rcx
               	addq	%rsi, %rcx
               	addq	%rdi, %rcx
               	andq	$0xff, %rax
               	addq	%rcx, %rax
               	cmpq	$0x404, %rax            # imm = 0x404
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, -0x20(%rbp)
               	leaq	-0x20(%rbp), %rax
               	movl	$0x15, %ecx
               	movq	%rcx, (%rax)
               	leaq	(%rcx,%rcx), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x5, %eax
               	movq	%rax, -0x28(%rbp)
               	leaq	-0x28(%rbp), %rax
               	movl	$0x9, %ecx
               	movq	%rcx, (%rax)
               	movq	%rcx, (%rax)
               	leaq	(%rcx,%rcx), %rdx
               	addq	$0x0, %rdx
               	leaq	(%rdx,%rcx), %rax
               	cmpq	$0x1b, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
