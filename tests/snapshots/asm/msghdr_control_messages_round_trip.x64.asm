
msghdr_control_messages_round_trip.x64:	file format elf64-x86-64

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

<ipv6_pktinfo>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xe0, %rsp
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x1c, -0xd8(%rbp)
               	movb	$0x36, -0xd0(%rbp)
               	movl	$0x1, -0xc8(%rbp)
               	xorl	%edx, %edx
               	movl	$0xa, %edi
               	movl	$0x2, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	testl	%r12d, %r12d
               	jge	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x14, %edx
               	movl	(%rax), %eax
               	cmpl	$0x61, %eax
               	cmovneq	%rdx, %rcx
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x98(%rbp), %rsi
               	movl	$0x0, -0x98(%rbp)
               	movl	$0x0, -0x94(%rbp)
               	movl	$0x0, -0x90(%rbp)
               	movl	$0x0, -0x8c(%rbp)
               	movl	$0x0, -0x88(%rbp)
               	movl	$0x0, -0x84(%rbp)
               	movl	$0x0, -0x80(%rbp)
               	movw	$0xa, -0x98(%rbp)
               	movb	$0x1, -0x81(%rbp)
               	movl	$0x1c, %edx
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x15, %edx
               	movl	(%rax), %eax
               	cmpl	$0x63, %eax
               	cmovneq	%rdx, %rcx
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x98(%rbp), %rsi
               	leaq	-0xd8(%rbp), %rdx
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x29, %esi
               	movl	$0x31, %edx
               	leaq	-0xc8(%rbp), %rcx
               	movl	$0x4, %r8d
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0xd0(%rbp), %rsi
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	leaq	-0x98(%rbp), %r8
               	movl	$0x1c, %r9d
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0xd0(%rbp), %rax
               	movq	%rax, -0xc0(%rbp)
               	movq	$0x1, -0xb8(%rbp)
               	xorl	%edx, %edx
               	movq	%rdx, -0x78(%rbp)
               	movq	%rdx, -0x70(%rbp)
               	movq	%rdx, -0x68(%rbp)
               	movq	%rdx, -0x60(%rbp)
               	movq	%rdx, -0x58(%rbp)
               	movq	%rdx, -0x50(%rbp)
               	movq	%rdx, -0x48(%rbp)
               	leaq	-0xc0(%rbp), %rcx
               	movq	%rcx, -0x68(%rbp)
               	leaq	-0x78(%rbp), %rsi
               	movq	$0x1, -0x60(%rbp)
               	leaq	-0x40(%rbp), %rax
               	movq	%rax, -0x58(%rbp)
               	movq	$0x40, -0x50(%rbp)
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movsbq	-0xd0(%rbp), %rax
               	cmpl	$0x36, %eax
               	je	<addr>
               	movl	$0x19, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	-0x50(%rbp), %rax
               	cmpq	$0x10, %rax
               	jb	<addr>
               	movq	-0x58(%rbp), %rax
               	xorl	%ebx, %ebx
               	testq	%rax, %rax
               	je	<addr>
               	movl	0x8(%rax), %ecx
               	cmpl	$0x29, %ecx
               	jne	<addr>
               	movl	0xc(%rax), %ecx
               	cmpl	$0x32, %ecx
               	jne	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x24, %rcx
               	jne	<addr>
               	leaq	-0xb0(%rbp), %rcx
               	leaq	0x10(%rax), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movl	0x10(%rdx), %r10d
               	movl	%r10d, 0x10(%rcx)
               	xorl	%ecx, %ecx
               	cmpl	$0x0, -0xb0(%rbp)
               	jne	<addr>
               	movl	-0xac(%rbp), %edx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	-0xa8(%rbp), %edx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movzbq	-0xa4(%rbp), %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%ebx, %ebx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	-0xa3(%rbp), %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	-0xa2(%rbp), %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	-0xa1(%rbp), %rcx
               	cmpl	$0x1, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	-0xa0(%rbp), %ecx
               	testl	%ecx, %ecx
               	seta	%bl
               	movzbq	%bl, %rbx
               	jmp	<addr>
               	movq	%rbx, %rcx
               	jmp	<addr>
               	movq	%rbx, %rcx
               	jmp	<addr>
               	movq	%rbx, %rcx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	leaq	-0x78(%rbp), %rdi
               	movq	%rax, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	movl	$0x1b, %ecx
               	testq	%rbx, %rbx
               	cmoveq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x1a, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	xorl	%edx, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	testl	%ebx, %ebx
               	jl	<addr>
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x10, -0x28(%rbp)
               	movl	$0x1, -0xe8(%rbp)
               	xorl	%edx, %edx
               	movl	$0x2, %edi
               	movq	%rdi, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r13
               	movl	$0x0, -0x10(%rbp)
               	movl	$0x0, -0xc(%rbp)
               	movl	$0x0, -0x8(%rbp)
               	movl	$0x0, -0x4(%rbp)
               	movw	$0x2, -0x10(%rbp)
               	movl	$0x7f000001, %edi       # imm = 0x7F000001
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	%eax, -0xc(%rbp)
               	testl	%r13d, %r13d
               	jl	<addr>
               	leaq	-0x10(%rbp), %rsi
               	movl	$0x10, %edx
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0xffffffff, -0x18(%rbp) # imm = 0xFFFFFFFF
               	movb	$0x72, -0x20(%rbp)
               	xorl	%edx, %edx
               	movb	%dl, -0x28(%rbp)
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	leaq	-0x8(%rbp), %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x10(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1e, %eax
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	-0x40(%rbp), %rsi
               	movq	$0x0, -0x40(%rbp)
               	movq	$0x0, -0x38(%rbp)
               	movq	$0x0, -0x30(%rbp)
               	movq	$0x0, -0x28(%rbp)
               	movq	$0x0, -0x20(%rbp)
               	movq	$0x0, -0x18(%rbp)
               	movq	$0x0, -0x10(%rbp)
               	movq	$0x0, -0x8(%rbp)
               	leaq	-0x78(%rbp), %rdi
               	movq	$0x0, -0x78(%rbp)
               	movq	$0x0, -0x70(%rbp)
               	movq	$0x0, -0x68(%rbp)
               	movq	$0x0, -0x60(%rbp)
               	movq	$0x0, -0x58(%rbp)
               	movq	$0x0, -0x50(%rbp)
               	movq	$0x0, -0x48(%rbp)
               	movq	%rsi, -0x58(%rbp)
               	movq	$0x30, -0x50(%rbp)
               	movq	$0x14, (%rsi)
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	-0x40(%rbp), %rax
               	addq	$0x18, %rax
               	cmpq	%rax, %rsi
               	je	<addr>
               	movl	$0x29, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	$0x13, (%rsi)
               	leaq	-0x78(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2a, %eax
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rax
               	addq	$0x10, %rax
               	leaq	-0x40(%rbp), %rcx
               	addq	$0x10, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x2b, %eax
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rsi
               	movq	$0x0, (%rsi)
               	leaq	-0x78(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2d, %eax
               	jmp	<addr>
               	leaq	-0x40(%rbp), %rsi
               	movq	$-0x1, (%rsi)
               	leaq	-0x78(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2e, %eax
               	jmp	<addr>
               	movq	$0xf, -0x50(%rbp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	leaq	-0x38(%rbp), %rsi
               	leaq	-0x20(%rbp), %rax
               	movq	%rax, -0x38(%rbp)
               	movq	$0x1, -0x30(%rbp)
               	movq	$0x0, -0x70(%rbp)
               	movq	$0x0, -0x68(%rbp)
               	movq	$0x0, -0x60(%rbp)
               	movq	$0x0, -0x58(%rbp)
               	movq	$0x0, -0x50(%rbp)
               	movq	$0x0, -0x48(%rbp)
               	movq	$0x0, -0x40(%rbp)
               	leaq	-0xb0(%rbp), %rcx
               	movq	$0x0, -0xb0(%rbp)
               	movq	$0x0, -0xa8(%rbp)
               	movq	$0x0, -0xa0(%rbp)
               	movq	$0x0, -0x98(%rbp)
               	movq	$0x0, -0x90(%rbp)
               	movq	$0x0, -0x88(%rbp)
               	movq	$0x0, -0x80(%rbp)
               	movq	$0x0, -0x78(%rbp)
               	movq	%rsi, -0x60(%rbp)
               	movq	$0x1, -0x58(%rbp)
               	movq	%rcx, -0x50(%rbp)
               	leaq	-0x70(%rbp), %rsi
               	movq	$0x18, -0x48(%rbp)
               	movl	$0x1, 0x8(%rcx)
               	movl	$0x1, 0xc(%rcx)
               	movq	$0x14, (%rcx)
               	leaq	0x10(%rcx), %rax
               	leaq	-0x10(%rbp), %rcx
               	addq	$0x4, %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	xorl	%edx, %edx
               	movl	-0x8(%rbp), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x1f, %eax
               	jmp	<addr>
               	xorl	%edx, %edx
               	movq	%rdx, -0xb0(%rbp)
               	movq	%rdx, -0xa8(%rbp)
               	movq	%rdx, -0xa0(%rbp)
               	movq	%rdx, -0x98(%rbp)
               	movq	%rdx, -0x90(%rbp)
               	movq	%rdx, -0x88(%rbp)
               	movq	%rdx, -0x80(%rbp)
               	movq	%rdx, -0x78(%rbp)
               	leaq	-0x70(%rbp), %rsi
               	movq	$0x40, -0x48(%rbp)
               	movb	%dl, -0x20(%rbp)
               	movl	-0x4(%rbp), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movsbq	-0x20(%rbp), %rax
               	cmpl	$0x72, %eax
               	je	<addr>
               	movl	$0x20, %eax
               	jmp	<addr>
               	movq	-0x48(%rbp), %rax
               	cmpq	$0x10, %rax
               	jb	<addr>
               	movq	-0x50(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	0x8(%rax), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	0xc(%rax), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x14, %rcx
               	je	<addr>
               	movl	$0x21, %eax
               	jmp	<addr>
               	leaq	-0x18(%rbp), %rcx
               	addq	$0x10, %rax
               	movl	(%rax), %r10d
               	movl	%r10d, (%rcx)
               	movl	-0x18(%rbp), %edi
               	movl	-0xc(%rbp), %eax
               	cmpl	%eax, %edi
               	je	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x1, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movl	-0x10(%rbp), %edi
               	leaq	-0x28(%rbp), %rsi
               	movl	$0x1, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movsbq	-0x28(%rbp), %rax
               	cmpl	$0x78, %eax
               	je	<addr>
               	movl	$0x22, %eax
               	jmp	<addr>
               	movl	-0x18(%rbp), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	-0x10(%rbp), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	-0xc(%rbp), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	-0x8(%rbp), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	-0x4(%rbp), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	leaq	-0x10(%rbp), %rsi
               	leaq	-0x28(%rbp), %rdx
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	jmp	<addr>
               	xorl	%esi, %esi
               	movl	$0x8, %edx
               	leaq	-0xe8(%rbp), %rcx
               	movl	$0x4, %r8d
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	jmp	<addr>
               	xorl	%edx, %edx
               	leaq	<rip>, %rax
               	movq	%rax, -0x58(%rbp)
               	movq	$0x3, -0x50(%rbp)
               	leaq	<rip>, %rax
               	movq	%rax, -0x48(%rbp)
               	movq	$0x5, -0x40(%rbp)
               	movq	$0x0, -0x90(%rbp)
               	movq	$0x0, -0x88(%rbp)
               	movq	$0x0, -0x80(%rbp)
               	movq	$0x0, -0x78(%rbp)
               	movq	$0x0, -0x70(%rbp)
               	movq	$0x0, -0x68(%rbp)
               	movq	$0x0, -0x60(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	%rax, -0x90(%rbp)
               	movl	$0x10, -0x88(%rbp)
               	leaq	-0x90(%rbp), %rsi
               	leaq	-0x58(%rbp), %rax
               	movq	%rax, -0x80(%rbp)
               	movq	$0x2, -0x78(%rbp)
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	jmp	<addr>
               	xorl	%edx, %edx
               	leaq	-0x30(%rbp), %rax
               	movq	%rax, -0x58(%rbp)
               	movq	$0x4, -0x50(%rbp)
               	leaq	-0x38(%rbp), %rax
               	movq	%rax, -0x48(%rbp)
               	movq	$0x8, -0x40(%rbp)
               	movq	$0x0, -0x90(%rbp)
               	movq	$0x0, -0x88(%rbp)
               	movq	$0x0, -0x80(%rbp)
               	movq	$0x0, -0x78(%rbp)
               	movq	$0x0, -0x70(%rbp)
               	movq	$0x0, -0x68(%rbp)
               	movq	$0x0, -0x60(%rbp)
               	leaq	-0x20(%rbp), %rsi
               	movl	$0x0, -0x20(%rbp)
               	movl	$0x0, -0x1c(%rbp)
               	movl	$0x0, -0x18(%rbp)
               	movl	$0x0, -0x14(%rbp)
               	movq	%rsi, -0x90(%rbp)
               	movl	$0x10, -0x88(%rbp)
               	leaq	-0x58(%rbp), %rax
               	movq	%rax, -0x80(%rbp)
               	movq	$0x2, -0x78(%rbp)
               	leaq	-0xd0(%rbp), %rax
               	movq	%rax, -0x70(%rbp)
               	movq	$0x40, -0x68(%rbp)
               	leaq	-0x90(%rbp), %rsi
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x38(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	jmp	<addr>
               	movl	-0x88(%rbp), %eax
               	cmpl	$0x10, %eax
               	jne	<addr>
               	movzwq	-0x1e(%rbp), %rax
               	movzwq	-0xe(%rbp), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movl	-0x1c(%rbp), %ebx
               	movl	$0x7f000001, %edi       # imm = 0x7F000001
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	%eax, %eax
               	cmpq	%rax, %rbx
               	je	<addr>
               	movl	$0x10, %eax
               	jmp	<addr>
               	movl	-0x60(%rbp), %eax
               	testb	$0x28, %al
               	je	<addr>
               	movl	$0x11, %eax
               	jmp	<addr>
               	movq	-0x68(%rbp), %rax
               	cmpq	$0x10, %rax
               	jb	<addr>
               	movq	-0x70(%rbp), %rbx
               	xorl	%r12d, %r12d
               	testq	%rbx, %rbx
               	je	<addr>
               	cmpl	$0x0, 0x8(%rbx)
               	jne	<addr>
               	movl	0xc(%rbx), %eax
               	cmpl	$0x8, %eax
               	jne	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x1c, %rax
               	jne	<addr>
               	leaq	-0xe0(%rbp), %rax
               	leaq	0x10(%rbx), %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	movl	0x8(%rcx), %r10d
               	movl	%r10d, 0x8(%rax)
               	movl	-0xd8(%rbp), %r12d
               	movl	$0x7f000001, %edi       # imm = 0x7F000001
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	%eax, %eax
               	cmpq	%rax, %r12
               	sete	%al
               	movzbq	%al, %rax
               	xorl	%r12d, %r12d
               	testq	%rax, %rax
               	je	<addr>
               	movl	-0xe0(%rbp), %eax
               	testl	%eax, %eax
               	setg	%r12b
               	movzbq	%r12b, %r12
               	leaq	-0x90(%rbp), %rdi
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	movl	$0x13, %ecx
               	testq	%r12, %r12
               	cmoveq	%rcx, %rax
               	jmp	<addr>
               	movl	$0x12, %eax
               	jmp	<addr>
               	xorl	%ebx, %ebx
               	jmp	<addr>
