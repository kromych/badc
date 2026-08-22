
gcc_vector_subscript.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	leaq	-0x10(%rbp), %rdx
               	leaq	<rip>, %rax
               	pushq	%rcx
               	movq	(%rax), %rcx
               	movq	%rcx, (%rdx)
               	movq	0x8(%rax), %rcx
               	movq	%rcx, 0x8(%rdx)
               	popq	%rcx
               	movq	%rdx, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	%rax, %rcx
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rsi
               	movzbq	(%rsi), %rsi
               	movq	%rcx, %rdi
               	andq	$0xff, %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movl	%eax, %ecx
               	cmpl	$0x10, %ecx
               	jb	<addr>
               	leaq	-0x10(%rbp), %rax
               	movl	$0x63, %ecx
               	movb	%cl, 0x3(%rax)
               	movl	$0xc8, %ecx
               	movb	%cl, 0xa(%rax)
               	movzbq	0x3(%rax), %rcx
               	xorq	$0x63, %rcx
               	movl	%ecx, %edx
               	testl	%edx, %edx
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movzbq	0xa(%rax), %rax
               	xorq	$0xc8, %rax
               	movl	%eax, %eax
               	testl	%eax, %eax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	movl	$0x3, %eax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
