
ternary_middle_comma.x64:	file format elf64-x86-64

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

<rt>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	%edi, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r12d, %r12d
               	movl	$0x2a, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	%ebx, %ecx
               	cmpl	$0x80, %ecx
               	jae	<addr>
               	movq	%rbx, %r12
               	andq	$0xff, %r12
               	movl	$0x1, %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movq	%r12, %rdx
               	xorq	$0x2a, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%eax, %rsi
               	movq	%r12, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	xorl	%r12d, %r12d
               	cmpl	$0x80, %ecx
               	jae	<addr>
               	movq	%rbx, %rdx
               	andq	$0xff, %rdx
               	movl	$0x1, %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movq	%rdx, %rsi
               	xorq	$0x2a, %rsi
               	testl	%esi, %esi
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%eax, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	cmpl	$0x80, %ecx
               	jae	<addr>
               	movq	%rbx, %rdx
               	andq	$0xff, %rdx
               	movl	$0x1, %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movq	%rdx, %rcx
               	xorq	$0x2a, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%eax, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movq	%r12, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	testl	%ebx, %ebx
               	jle	<addr>
               	movl	$0x1, %r14d
               	movl	$0x2, %r13d
               	movl	$0x3, %ecx
               	movl	$0x6, %eax
               	cmpl	$0x6, %eax
               	jne	<addr>
               	cmpl	$0x1, %r14d
               	jne	<addr>
               	cmpl	$0x2, %r13d
               	jne	<addr>
               	cmpl	$0x3, %ecx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%eax, %rsi
               	movslq	%r14d, %rdx
               	movslq	%r13d, %rax
               	movslq	%ecx, %r8
               	movq	%rax, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	xorl	%ebx, %ebx
               	movl	$0xc8, %edi
               	callq	<addr>
               	movl	%eax, %ecx
               	cmpl	$0x80, %ecx
               	jae	<addr>
               	movq	%rax, %rbx
               	andq	$0xff, %rbx
               	movl	$0x1, %eax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	testl	%ebx, %ebx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%eax, %rsi
               	movq	%rbx, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq
               	movl	$0x63, %eax
               	jmp	<addr>
               	movq	$-0x1, %rax
               	jmp	<addr>
               	movl	$0x63, %eax
               	movq	%r12, %rdx
               	jmp	<addr>
               	movl	$0x63, %eax
               	movq	%r12, %rdx
               	jmp	<addr>
               	movl	$0x63, %eax
               	jmp	<addr>
