
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
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x2a, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	cmpl	$0x80, %ebx
               	jae	<addr>
               	movq	%rbx, %rdx
               	andq	$0xff, %rdx
               	movl	$0x1, %esi
               	cmpl	$0x1, %esi
               	jne	<addr>
               	movq	%rdx, %rax
               	xorq	$0x2a, %rax
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%edi, %edi
               	cmpl	$0x80, %ebx
               	jae	<addr>
               	movq	%rbx, %rdx
               	andq	$0xff, %rdx
               	movl	$0x1, %esi
               	cmpl	$0x1, %esi
               	jne	<addr>
               	movq	%rdx, %rax
               	xorq	$0x2a, %rax
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	cmpl	$0x80, %ebx
               	jae	<addr>
               	movq	%rbx, %rdx
               	andq	$0xff, %rdx
               	movl	$0x1, %esi
               	cmpl	$0x1, %esi
               	jne	<addr>
               	movq	%rdx, %rax
               	xorq	$0x2a, %rax
               	testl	%eax, %eax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	callq	<addr>
               	movq	%rax, %r13
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	xorl	%edi, %edi
               	callq	<addr>
               	testl	%ebx, %ebx
               	jle	<addr>
               	movl	$0x1, %r13d
               	movl	$0x2, %r12d
               	movl	$0x3, %eax
               	movl	$0x6, %esi
               	cmpl	$0x6, %esi
               	jne	<addr>
               	cmpl	$0x1, %r13d
               	jne	<addr>
               	cmpl	$0x2, %r12d
               	jne	<addr>
               	cmpl	$0x3, %eax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movslq	%r13d, %rdx
               	movslq	%r12d, %rcx
               	movslq	%eax, %r8
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0xc8, %edi
               	callq	<addr>
               	cmpl	$0x80, %eax
               	jae	<addr>
               	movq	%rax, %rdx
               	andq	$0xff, %rdx
               	movl	$0x1, %esi
               	cmpl	$0x63, %esi
               	jne	<addr>
               	testl	%edx, %edx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x63, %esi
               	xorl	%edx, %edx
               	jmp	<addr>
               	movq	$-0x1, %rsi
               	jmp	<addr>
               	movl	$0x63, %esi
               	movq	%rdi, %rdx
               	jmp	<addr>
               	movl	$0x63, %esi
               	movq	%rdi, %rdx
               	jmp	<addr>
               	movl	$0x63, %esi
               	xorl	%edx, %edx
               	jmp	<addr>
