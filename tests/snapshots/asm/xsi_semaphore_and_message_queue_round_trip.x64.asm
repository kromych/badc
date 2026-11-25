
xsi_semaphore_and_message_queue_round_trip.x64:	file format elf64-x86-64

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

<semaphores>:
               	subq	$0xb0, %rsp
               	pushq	%rbx
               	leaq	0x28(%rsp), %rax
               	leaq	<rip>, %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	xorl	%edi, %edi
               	movl	$0x2, %esi
               	movl	$0x380, %edx            # imm = 0x380
               	callq	<addr>
               	movq	%rax, %rbx
               	testl	%ebx, %ebx
               	jge	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	addq	$0xb0, %rsp
               	retq
               	leaq	0x30(%rsp), %rcx
               	leaq	0x28(%rsp), %rax
               	movq	%rax, 0x30(%rsp)
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
               	addq	$0xb0, %rsp
               	retq
               	leaq	0x30(%rsp), %rcx
               	movl	$0x7, 0x30(%rsp)
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
               	addq	$0xb0, %rsp
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
               	addq	$0xb0, %rsp
               	retq
               	leaq	0x38(%rsp), %rsi
               	movabsq	$0x10000fffe0000, %rax  # imm = 0x10000FFFE0000
               	movq	%rax, 0x38(%rsp)
               	movl	$0x10000001, 0x40(%rsp) # imm = 0x10000001
               	movl	$0x2, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	addq	$0xb0, %rsp
               	retq
               	leaq	0x38(%rsp), %rsi
               	movw	$0xfffe, 0x3a(%rsp)     # imm = 0xFFFE
               	movw	$0x800, 0x3c(%rsp)      # imm = 0x800
               	movl	$0x1, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0xb, %eax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	addq	$0xb0, %rsp
               	retq
               	leaq	0x28(%rsp), %rax
               	movl	$0xffffffff, 0x28(%rsp) # imm = 0xFFFFFFFF
               	leaq	0x30(%rsp), %rcx
               	movq	%rax, 0x30(%rsp)
               	xorl	%esi, %esi
               	movl	$0xd, %edx
               	movq	%rbx, %rdi
               	movq	(%rcx), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movzwq	0x28(%rsp), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movzwq	0x2a(%rsp), %rax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	addq	$0xb0, %rsp
               	retq
               	xorl	%esi, %esi
               	movl	$0xb, %edx
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	0x18(%rsp), %rax
               	cmpq	%r10, %rax
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	addq	$0xb0, %rsp
               	retq
               	leaq	0x30(%rsp), %rcx
               	leaq	0x48(%rsp), %rax
               	movq	%rax, 0x30(%rsp)
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
               	addq	$0xb0, %rsp
               	retq
               	movq	0x98(%rsp), %rax
               	cmpq	$0x2, %rax
               	jne	<addr>
               	movl	0x5c(%rsp), %eax
               	andq	$0x1ff, %rax            # imm = 0x1FF
               	cmpl	$0x180, %eax            # imm = 0x180
               	je	<addr>
               	movl	$0x13, %eax
               	popq	%rbx
               	addq	$0xb0, %rsp
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
               	addq	$0xb0, %rsp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0xb0, %rsp
               	retq

<main>:
               	subq	$0xb0, %rsp
               	pushq	%rbx
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbx
               	addq	$0xb0, %rsp
               	retq
               	xorl	%edi, %edi
               	movl	$0x380, %esi            # imm = 0x380
               	callq	<addr>
               	movq	%rax, %rbx
               	testl	%ebx, %ebx
               	jge	<addr>
               	movl	$0x1e, %eax
               	popq	%rbx
               	addq	$0xb0, %rsp
               	retq
               	leaq	0x20(%rsp), %rax
               	movq	$0x1, 0x20(%rsp)
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	leaq	0x20(%rsp), %rsi
               	movl	$0x6, %edx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1f, %eax
               	jmp	<addr>
               	leaq	0x20(%rsp), %rax
               	movq	$0x2, 0x20(%rsp)
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	leaq	0x20(%rsp), %rsi
               	movl	$0xf, %edx
               	movl	$0x800, %ecx            # imm = 0x800
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x20, %eax
               	jmp	<addr>
               	movl	$0x2, %esi
               	leaq	0x38(%rsp), %rdx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x21, %eax
               	jmp	<addr>
               	movq	0x88(%rsp), %rax
               	cmpq	$0x2, %rax
               	jne	<addr>
               	movslq	0x98(%rsp), %r10
               	movq	%r10, 0x18(%rsp)
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	0x18(%rsp), %rax
               	cmpq	%r10, %rax
               	jne	<addr>
               	movl	0x4c(%rsp), %eax
               	andq	$0x1ff, %rax            # imm = 0x1FF
               	cmpl	$0x180, %eax            # imm = 0x180
               	je	<addr>
               	movl	$0x22, %eax
               	jmp	<addr>
               	leaq	0x20(%rsp), %rsi
               	xorl	%r8d, %r8d
               	movq	%r8, 0x20(%rsp)
               	movq	%r8, 0x28(%rsp)
               	movq	%r8, 0x30(%rsp)
               	movl	$0x10, %edx
               	movl	$0x2, %ecx
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0xf, %rax
               	jne	<addr>
               	leaq	0x20(%rsp), %rax
               	movq	0x20(%rsp), %rcx
               	cmpq	$0x2, %rcx
               	jne	<addr>
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x23, %eax
               	jmp	<addr>
               	leaq	0x20(%rsp), %rsi
               	movl	$0x3, %edx
               	xorl	%ecx, %ecx
               	movl	$0x800, %r8d            # imm = 0x800
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x24, %eax
               	jmp	<addr>
               	leaq	0x20(%rsp), %rsi
               	xorl	%ecx, %ecx
               	movq	%rcx, 0x20(%rsp)
               	movq	%rcx, 0x28(%rsp)
               	movq	%rcx, 0x30(%rsp)
               	movl	$0x3, %edx
               	movl	$0x1000, %r8d           # imm = 0x1000
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x3, %rax
               	jne	<addr>
               	leaq	0x20(%rsp), %rax
               	movq	0x20(%rsp), %rcx
               	cmpq	$0x1, %rcx
               	jne	<addr>
               	leaq	0x8(%rax), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x25, %eax
               	jmp	<addr>
               	leaq	0x20(%rsp), %rsi
               	movl	$0x10, %edx
               	xorl	%ecx, %ecx
               	movl	$0x800, %r8d            # imm = 0x800
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x26, %eax
               	jmp	<addr>
               	movl	$0x2, %esi
               	leaq	0x38(%rsp), %rdx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0x0, 0x88(%rsp)
               	jne	<addr>
               	movslq	0x9c(%rsp), %r10
               	movq	%r10, 0x18(%rsp)
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	0x18(%rsp), %rax
               	cmpq	%r10, %rax
               	je	<addr>
               	movl	$0x27, %eax
               	jmp	<addr>
               	xorl	%esi, %esi
               	movq	%rbx, %rdi
               	movq	%rsi, %rdx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x28, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
