
address_retested_after_calls.x64:	file format elf64-x86-64

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

<movable>:
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movq	(%rdi), %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	retq

<enable>:
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	retq

<report>:
               	movq	%rdi, %rax
               	xorq	$0x40, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	testq	%rsi, %rsi
               	je	<addr>
               	cmpq	$0x0, (%rsi)
               	jne	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>

<check>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x40, %edi
               	leaq	<rip>, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	callq	<addr>
               	popq	%rbp
               	retq
               	xorl	%esi, %esi
               	jmp	<addr>
               	xorl	%edi, %edi
               	jmp	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movq	(%rax), %rbx
               	movq	0x8(%rax), %r12
               	movq	0x10(%rax), %r13
               	movq	0x18(%rax), %r14
               	movq	0x20(%rax), %r15
               	movq	0x28(%rax), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x30(%rax), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x38(%rax), %r10
               	movq	%r10, 0x38(%rsp)
               	callq	<addr>
               	leaq	(%rbx,%r12), %rcx
               	addq	%r13, %rcx
               	addq	%r14, %rcx
               	addq	%r15, %rcx
               	addq	0x48(%rsp), %rcx
               	addq	0x40(%rsp), %rcx
               	addq	0x38(%rsp), %rcx
               	addq	%rax, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x4, %eax
               	jmp	<addr>
