
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
               	subq	$0xa0, %rsp
               	leaq	-0x88(%rbp), %rax
               	leaq	<rip>, %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	xorl	%edi, %edi
               	movl	$0x2, %esi
               	movl	$0x380, %edx            # imm = 0x380
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x8(%rsp), %rax
               	testl	%eax, %eax
               	jge	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	leaq	-0x80(%rbp), %rcx
               	leaq	-0x88(%rbp), %rax
               	movq	%rax, -0x80(%rbp)
               	xorl	%esi, %esi
               	movl	$0x11, %edx
               	movq	0x8(%rsp), %rdi
               	movq	(%rcx), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	leaq	-0x80(%rbp), %rcx
               	movl	$0x7, -0x80(%rbp)
               	movl	$0x1, %esi
               	movl	$0x10, %edx
               	movq	0x8(%rsp), %rdi
               	movq	(%rcx), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	xorl	%esi, %esi
               	movl	$0xc, %edx
               	movq	0x8(%rsp), %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movl	$0x1, %esi
               	movl	$0xc, %edx
               	movq	0x8(%rsp), %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movabsq	$0x10000fffe0000, %rax  # imm = 0x10000FFFE0000
               	movq	%rax, -0x78(%rbp)
               	movl	$0x10000001, -0x70(%rbp) # imm = 0x10000001
               	leaq	-0x78(%rbp), %rsi
               	movl	$0x2, %edx
               	movq	0x8(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	leaq	-0x78(%rbp), %rsi
               	movw	$0xfffe, -0x76(%rbp)    # imm = 0xFFFE
               	movw	$0x800, -0x74(%rbp)     # imm = 0x800
               	movl	$0x1, %edx
               	movq	0x8(%rsp), %rdi
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
               	leave
               	retq
               	leaq	-0x88(%rbp), %rax
               	movl	$0xffffffff, -0x88(%rbp) # imm = 0xFFFFFFFF
               	leaq	-0x80(%rbp), %rcx
               	movq	%rax, -0x80(%rbp)
               	xorl	%esi, %esi
               	movl	$0xd, %edx
               	movq	0x8(%rsp), %rdi
               	movq	(%rcx), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzwq	-0x88(%rbp), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movzwq	-0x86(%rbp), %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	xorl	%esi, %esi
               	movl	$0xb, %edx
               	movq	0x8(%rsp), %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	%r10, (%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	(%rsp), %rax
               	cmpq	%r10, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	leave
               	retq
               	leaq	-0x80(%rbp), %rcx
               	leaq	-0x68(%rbp), %rax
               	movq	%rax, -0x80(%rbp)
               	xorl	%esi, %esi
               	movl	$0x2, %edx
               	movq	0x8(%rsp), %rdi
               	movq	(%rcx), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x12, %eax
               	leave
               	retq
               	movq	-0x18(%rbp), %rax
               	cmpq	$0x2, %rax
               	jne	<addr>
               	movl	-0x54(%rbp), %eax
               	andq	$0x1ff, %rax            # imm = 0x1FF
               	cmpl	$0x180, %eax            # imm = 0x180
               	je	<addr>
               	movl	$0x13, %eax
               	leave
               	retq
               	xorl	%esi, %esi
               	movq	%rsi, %rdx
               	movq	0x8(%rsp), %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x14, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	pushq	%r12
               	pushq	%rbx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
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
               	jmp	<addr>
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
               	jmp	<addr>
               	movl	$0x2, %esi
               	leaq	-0x78(%rbp), %rdx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x21, %eax
               	jmp	<addr>
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
               	cmpl	$0x180, %eax            # imm = 0x180
               	je	<addr>
               	movl	$0x22, %eax
               	jmp	<addr>
               	leaq	-0x90(%rbp), %rsi
               	xorl	%r8d, %r8d
               	movq	%r8, -0x90(%rbp)
               	movq	%r8, -0x88(%rbp)
               	movq	%r8, -0x80(%rbp)
               	movl	$0x10, %edx
               	movl	$0x2, %ecx
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
               	jmp	<addr>
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
               	jmp	<addr>
               	leaq	-0x90(%rbp), %rsi
               	xorl	%ecx, %ecx
               	movq	%rcx, -0x90(%rbp)
               	movq	%rcx, -0x88(%rbp)
               	movq	%rcx, -0x80(%rbp)
               	movl	$0x3, %edx
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
               	jmp	<addr>
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
               	jmp	<addr>
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
               	jmp	<addr>
               	xorl	%esi, %esi
               	movq	%rbx, %rdi
               	movq	%rsi, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x28, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
