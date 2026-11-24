
posix_message_queue_round_trip.x64:	file format elf64-x86-64

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

<main>:
               	subq	$0x108, %rsp            # imm = 0x108
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	movl	%ebx, 0x28(%rsp)
               	movq	%rbx, 0xa0(%rsp)
               	movq	%rbx, 0xb8(%rsp)
               	movq	%rbx, 0xc0(%rsp)
               	movq	%rbx, 0xc8(%rsp)
               	movq	%rbx, 0xd0(%rsp)
               	movq	%rbx, 0xd8(%rsp)
               	movq	$0x4, 0xa8(%rsp)
               	leaq	<rip>, %r13
               	movq	$0x40, 0xb0(%rsp)
               	jmp	<addr>
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x11, %eax
               	jne	<addr>
               	cmpl	$0x3e8, %ebx            # imm = 0x3E8
               	je	<addr>
               	incq	%rbx
               	leaq	0x40(%rsp), %r12
               	movl	$0x20, %r14d
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r12, %rdi
               	movq	%rbx, %r8
               	movq	%r13, %rdx
               	movq	%r14, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	0x40(%rsp), %rdi
               	movl	$0xc2, %esi
               	movl	$0x180, %edx            # imm = 0x180
               	leaq	0xa0(%rsp), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %r12
               	cmpl	$-0x1, %r12d
               	je	<addr>
               	cmpl	$-0x1, %r12d
               	jne	<addr>
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movl	$0xb, %edx
               	movl	(%rax), %eax
               	cmpl	$0x26, %eax
               	movq	%rdx, %rax
               	cmoveq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	addq	$0x108, %rsp            # imm = 0x108
               	retq
               	leaq	0x40(%rsp), %rdi
               	callq	<addr>
               	leaq	0xe0(%rsp), %rsi
               	movq	%r12, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	jmp	<addr>
               	movq	0xe8(%rsp), %rax
               	cmpq	$0x4, %rax
               	jne	<addr>
               	movq	0xf0(%rsp), %rax
               	cmpq	$0x40, %rax
               	jne	<addr>
               	cmpq	$0x0, 0xf8(%rsp)
               	je	<addr>
               	movl	$0xd, %eax
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x4, %edx
               	movl	$0x1, %ecx
               	movq	%r12, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x5, %edx
               	movl	$0x7, %ecx
               	movq	%r12, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	jmp	<addr>
               	leaq	0xe0(%rsp), %rsi
               	movq	%r12, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0xf8(%rsp), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	jmp	<addr>
               	leaq	0x60(%rsp), %rsi
               	movl	$0x40, %edx
               	leaq	0x28(%rsp), %rcx
               	movq	%r12, %rdi
               	callq	<addr>
               	cmpq	$0x5, %rax
               	jne	<addr>
               	movl	0x28(%rsp), %eax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	jmp	<addr>
               	xorl	%edi, %edi
               	leaq	0x30(%rsp), %rsi
               	callq	<addr>
               	leaq	0x30(%rsp), %r8
               	addq	$0x5, 0x30(%rsp)
               	leaq	0x60(%rsp), %rsi
               	movl	$0x40, %edx
               	leaq	0x28(%rsp), %rcx
               	movq	%r12, %rdi
               	callq	<addr>
               	cmpq	$0x4, %rax
               	jne	<addr>
               	movl	0x28(%rsp), %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	jmp	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x6, %edx
               	movl	$0x3, %ecx
               	leaq	0x30(%rsp), %r8
               	movq	%r12, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	jmp	<addr>
               	leaq	0x60(%rsp), %rsi
               	movl	$0x40, %edx
               	xorl	%ecx, %ecx
               	movq	%r12, %rdi
               	callq	<addr>
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x13, %eax
               	jmp	<addr>
               	leaq	0xa0(%rsp), %rsi
               	movq	$0x800, 0xa0(%rsp)      # imm = 0x800
               	leaq	0xe0(%rsp), %rdx
               	movq	%r12, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0x0, 0xe0(%rsp)
               	je	<addr>
               	movl	$0x14, %eax
               	jmp	<addr>
               	leaq	0x60(%rsp), %rsi
               	movl	$0x40, %edx
               	xorl	%ecx, %ecx
               	movq	%r12, %rdi
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	jmp	<addr>
               	leaq	0x60(%rsp), %rsi
               	movl	$0x8, %edx
               	xorl	%ecx, %ecx
               	movq	%r12, %rdi
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x5a, %eax
               	je	<addr>
               	movl	$0x16, %eax
               	jmp	<addr>
               	movq	%r12, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x17, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	movq	%rdx, %rax
               	cmovneq	%rcx, %rax
               	jmp	<addr>
