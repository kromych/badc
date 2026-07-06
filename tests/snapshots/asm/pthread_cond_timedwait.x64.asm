
pthread_cond_timedwait.x64:	file format elf64-x86-64

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
               	subq	$0xe0, %rsp
               	movq	%rbx, (%rsp)
               	leaq	-0x38(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rdi
               	xorq	%rsi, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x38(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x60(%rbp), %rdi
               	xorq	%rbx, %rbx
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	leaq	-0x90(%rbp), %rdi
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	leaq	-0x60(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	leaq	-0xa0(%rbp), %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	leaq	-0xa0(%rbp), %rax
               	movq	%rbx, 0x8(%rax)
               	leaq	-0x90(%rbp), %rdi
               	leaq	-0x60(%rbp), %rsi
               	leaq	-0xa0(%rbp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	leaq	-0x60(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	leaq	-0x90(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	leaq	-0x60(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%ebx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %eax
               	jmp	<addr>
