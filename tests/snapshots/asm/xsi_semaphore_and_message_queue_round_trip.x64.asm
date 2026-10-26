
xsi_semaphore_and_message_queue_round_trip.x64:	file format elf64-x86-64

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

<semaphores>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	pushq	%r12
               	pushq	%rbx
               	leaq	-0x88(%rbp), %rax
               	leaq	<rip>, %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	xorl	%edi, %edi
               	movl	$0x2, %esi
               	movl	$0x380, %edx            # imm = 0x380
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	testl	%ebx, %ebx
               	jge	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x80(%rbp), %rcx
               	leaq	-0x88(%rbp), %rax
               	movq	%rax, -0x80(%rbp)
               	xorl	%esi, %esi
               	movl	$0x11, %edx
               	movq	%rbx, %rdi
               	movq	(%rcx), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x80(%rbp), %rcx
               	movl	$0x7, -0x80(%rbp)
               	movl	$0x1, %esi
               	movl	$0x10, %edx
               	movq	%rbx, %rdi
               	movq	(%rcx), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%esi, %esi
               	movl	$0xc, %edx
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movl	$0x1, %esi
               	movl	$0xc, %edx
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movw	$0x0, -0x78(%rbp)
               	movw	$0xfffe, -0x76(%rbp)    # imm = 0xFFFE
               	movw	$0x0, -0x74(%rbp)
               	movw	$0x1, -0x72(%rbp)
               	movw	$0x1, -0x70(%rbp)
               	movw	$0x1000, -0x6e(%rbp)    # imm = 0x1000
               	leaq	-0x78(%rbp), %rsi
               	movl	$0x2, %edx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x78(%rbp), %rsi
               	movw	$0xfffe, -0x76(%rbp)    # imm = 0xFFFE
               	movw	$0x800, -0x74(%rbp)     # imm = 0x800
               	movl	$0x1, %edx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x88(%rbp), %rdi
               	movl	$0xff, %esi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x80(%rbp), %rcx
               	leaq	-0x88(%rbp), %rax
               	movq	%rax, -0x80(%rbp)
               	xorl	%esi, %esi
               	movl	$0xd, %edx
               	movq	%rbx, %rdi
               	movq	(%rcx), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzwq	-0x88(%rbp), %rax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzwq	-0x86(%rbp), %rax
               	xorq	$0x8, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%esi, %esi
               	movl	$0xb, %edx
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	%rax, %r12
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x80(%rbp), %rcx
               	leaq	-0x68(%rbp), %rax
               	movq	%rax, -0x80(%rbp)
               	xorl	%esi, %esi
               	movl	$0x2, %edx
               	movq	%rbx, %rdi
               	movq	(%rcx), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	-0x18(%rbp), %rax
               	cmpq	$0x2, %rax
               	jne	<addr>
               	movl	-0x54(%rbp), %eax
               	andq	$0x1ff, %rax            # imm = 0x1FF
               	xorq	$0x180, %rax            # imm = 0x180
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x13, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%esi, %esi
               	movq	%rbx, %rdi
               	movq	%rsi, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<messages>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	pushq	%r12
               	pushq	%rbx
               	xorl	%edi, %edi
               	movl	$0x380, %esi            # imm = 0x380
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	testl	%ebx, %ebx
               	jge	<addr>
               	movl	$0x1e, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x90(%rbp), %rax
               	movq	$0x1, -0x90(%rbp)
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x90(%rbp), %rsi
               	movl	$0x6, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1f, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x90(%rbp), %rax
               	movq	$0x2, -0x90(%rbp)
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x90(%rbp), %rsi
               	movl	$0xf, %edx
               	movl	$0x800, %ecx            # imm = 0x800
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x20, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x2, %esi
               	leaq	-0x78(%rbp), %rdx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x21, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	-0x28(%rbp), %rax
               	cmpq	$0x2, %rax
               	jne	<addr>
               	movslq	-0x18(%rbp), %r12
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	%rax, %r12
               	jne	<addr>
               	movl	-0x64(%rbp), %eax
               	andq	$0x1ff, %rax            # imm = 0x1FF
               	xorq	$0x180, %rax            # imm = 0x180
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x22, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x90(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x18, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x90(%rbp), %rsi
               	movl	$0x10, %edx
               	movl	$0x2, %ecx
               	xorl	%r8d, %r8d
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0xf, %rax
               	jne	<addr>
               	leaq	-0x90(%rbp), %rax
               	movq	-0x90(%rbp), %rcx
               	cmpq	$0x2, %rcx
               	jne	<addr>
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x23, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x90(%rbp), %rsi
               	movl	$0x3, %edx
               	xorl	%ecx, %ecx
               	movl	$0x800, %r8d            # imm = 0x800
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x24, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x90(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x18, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x90(%rbp), %rsi
               	movl	$0x3, %edx
               	xorl	%ecx, %ecx
               	movl	$0x1000, %r8d           # imm = 0x1000
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x3, %rax
               	jne	<addr>
               	leaq	-0x90(%rbp), %rax
               	movq	-0x90(%rbp), %rcx
               	cmpq	$0x1, %rcx
               	jne	<addr>
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x25, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x90(%rbp), %rsi
               	movl	$0x10, %edx
               	xorl	%ecx, %ecx
               	movl	$0x800, %r8d            # imm = 0x800
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x26, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x2, %esi
               	leaq	-0x78(%rbp), %rdx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0x0, -0x28(%rbp)
               	jne	<addr>
               	movslq	-0x14(%rbp), %r12
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	%rax, %r12
               	je	<addr>
               	movl	$0x27, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%esi, %esi
               	movq	%rbx, %rdi
               	movq	%rsi, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x28, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbp
               	retq
               	callq	<addr>
               	popq	%rbp
               	retq
