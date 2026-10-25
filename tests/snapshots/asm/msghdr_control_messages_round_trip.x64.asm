
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

<ipv4_pktinfo>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x10, -0xe8(%rbp)
               	movl	$0x1, -0xd0(%rbp)
               	xorl	%edx, %edx
               	movl	$0x2, %edi
               	movq	%rdi, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0xc8(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movw	$0x2, -0xc8(%rbp)
               	movl	$0x7f000001, %edi       # imm = 0x7F000001
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	%eax, -0xc4(%rbp)
               	testl	%r13d, %r13d
               	jl	<addr>
               	leaq	-0xc8(%rbp), %rsi
               	movl	$0x10, %edx
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	-0xc8(%rbp), %rsi
               	leaq	-0xe8(%rbp), %rdx
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%esi, %esi
               	movl	$0x8, %edx
               	leaq	-0xd0(%rbp), %rcx
               	movl	$0x4, %r8d
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%esi, %esi
               	leaq	<rip>, %rax
               	movq	%rax, -0x98(%rbp)
               	movq	$0x3, -0x90(%rbp)
               	leaq	<rip>, %rax
               	movq	%rax, -0x88(%rbp)
               	movq	$0x5, -0x80(%rbp)
               	leaq	-0x78(%rbp), %rdi
               	movl	$0x38, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x78(%rbp), %rsi
               	leaq	-0xc8(%rbp), %rax
               	movq	%rax, -0x78(%rbp)
               	movl	$0x10, -0x70(%rbp)
               	leaq	-0x98(%rbp), %rax
               	movq	%rax, -0x68(%rbp)
               	movq	$0x2, -0x60(%rbp)
               	xorl	%edx, %edx
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%esi, %esi
               	leaq	-0xe0(%rbp), %rax
               	movq	%rax, -0x98(%rbp)
               	movq	$0x4, -0x90(%rbp)
               	leaq	-0xd8(%rbp), %rax
               	movq	%rax, -0x88(%rbp)
               	movq	$0x8, -0x80(%rbp)
               	leaq	-0x78(%rbp), %rdi
               	movl	$0x38, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0xb8(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0xb8(%rbp), %rax
               	movq	%rax, -0x78(%rbp)
               	movl	$0x10, -0x70(%rbp)
               	leaq	-0x98(%rbp), %rax
               	movq	%rax, -0x68(%rbp)
               	movq	$0x2, -0x60(%rbp)
               	leaq	-0x40(%rbp), %rax
               	movq	%rax, -0x58(%rbp)
               	leaq	-0x78(%rbp), %rsi
               	movq	$0x40, -0x50(%rbp)
               	xorl	%edx, %edx
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	-0xe0(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xd8(%rbp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	-0x70(%rbp), %eax
               	cmpl	$0x10, %eax
               	jne	<addr>
               	movzwq	-0xb6(%rbp), %rax
               	movzwq	-0xc6(%rbp), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movl	-0xb4(%rbp), %ebx
               	movl	$0x7f000001, %edi       # imm = 0x7F000001
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	%eax, %eax
               	cmpq	%rax, %rbx
               	je	<addr>
               	movl	$0x10, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	-0x48(%rbp), %eax
               	testb	$0x28, %al
               	je	<addr>
               	movl	$0x11, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	-0x50(%rbp), %rax
               	cmpq	$0x10, %rax
               	jb	<addr>
               	movq	-0x58(%rbp), %rbx
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
               	leaq	-0xa8(%rbp), %rdi
               	leaq	0x10(%rbx), %rsi
               	movl	$0xc, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	-0xa0(%rbp), %r12d
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
               	movl	-0xa8(%rbp), %eax
               	testl	%eax, %eax
               	setg	%r12b
               	movzbq	%r12b, %r12
               	leaq	-0x78(%rbp), %rdi
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%r12, %r12
               	je	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x13, %eax
               	jmp	<addr>
               	movl	$0x12, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%ebx, %ebx
               	jmp	<addr>

<ipv6_pktinfo>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xe8, %rsp
               	pushq	%r13
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
               	movq	%rax, %r13
               	testl	%r13d, %r13d
               	jge	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x61, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x14, %eax
               	jmp	<addr>
               	leaq	-0x98(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x1c, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x98(%rbp), %rsi
               	movw	$0xa, -0x98(%rbp)
               	movb	$0x1, -0x81(%rbp)
               	movl	$0x1c, %edx
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x63, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x15, %eax
               	jmp	<addr>
               	leaq	-0x98(%rbp), %rsi
               	leaq	-0xd8(%rbp), %rdx
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x29, %esi
               	movl	$0x31, %edx
               	leaq	-0xc8(%rbp), %rcx
               	movl	$0x4, %r8d
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	-0xd0(%rbp), %rsi
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	leaq	-0x98(%rbp), %r8
               	movl	$0x1c, %r9d
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	-0xd0(%rbp), %rax
               	movq	%rax, -0xc0(%rbp)
               	movq	$0x1, -0xb8(%rbp)
               	leaq	-0x78(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x38, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x78(%rbp), %rsi
               	leaq	-0xc0(%rbp), %rax
               	movq	%rax, -0x68(%rbp)
               	movq	$0x1, -0x60(%rbp)
               	leaq	-0x40(%rbp), %rax
               	movq	%rax, -0x58(%rbp)
               	movq	$0x40, -0x50(%rbp)
               	xorl	%edx, %edx
               	movq	%r13, %rdi
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
               	popq	%r13
               	leave
               	retq
               	movq	-0x50(%rbp), %rax
               	cmpq	$0x10, %rax
               	jb	<addr>
               	movq	-0x58(%rbp), %r12
               	xorl	%ebx, %ebx
               	testq	%r12, %r12
               	je	<addr>
               	movl	0x8(%r12), %eax
               	cmpl	$0x29, %eax
               	jne	<addr>
               	movl	0xc(%r12), %eax
               	cmpl	$0x32, %eax
               	jne	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x24, %rax
               	jne	<addr>
               	leaq	-0xb0(%rbp), %rdi
               	leaq	0x10(%r12), %rsi
               	movl	$0x14, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	cmpl	$0x0, -0xb0(%rbp)
               	jne	<addr>
               	movl	-0xac(%rbp), %ecx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	-0xa8(%rbp), %ecx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	-0xa4(%rbp), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	xorl	%ebx, %ebx
               	testq	%rax, %rax
               	je	<addr>
               	movzbq	-0xa3(%rbp), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movzbq	-0xa2(%rbp), %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movzbq	-0xa1(%rbp), %rax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	-0xa0(%rbp), %eax
               	testl	%eax, %eax
               	seta	%bl
               	movzbq	%bl, %rbx
               	jmp	<addr>
               	movq	%rbx, %rax
               	jmp	<addr>
               	movq	%rbx, %rax
               	jmp	<addr>
               	movq	%rbx, %rax
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	leaq	-0x78(%rbp), %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	testq	%r12, %r12
               	jne	<addr>
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rbx, %rbx
               	je	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x1b, %eax
               	jmp	<addr>
               	movl	$0x1a, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%r12d, %r12d
               	jmp	<addr>

<pass_descriptor>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
               	movl	$0xffffffff, -0xa0(%rbp) # imm = 0xFFFFFFFF
               	movb	$0x72, -0x98(%rbp)
               	xorl	%edx, %edx
               	movb	%dl, -0x90(%rbp)
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	leaq	-0xb0(%rbp), %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xa8(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1e, %eax
               	leave
               	retq
               	leaq	-0x98(%rbp), %rax
               	movq	%rax, -0x88(%rbp)
               	movq	$0x1, -0x80(%rbp)
               	leaq	-0x78(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x38, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x40(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x88(%rbp), %rax
               	movq	%rax, -0x68(%rbp)
               	movq	$0x1, -0x60(%rbp)
               	leaq	-0x40(%rbp), %rax
               	movq	%rax, -0x58(%rbp)
               	movq	$0x18, -0x50(%rbp)
               	movq	-0x58(%rbp), %rax
               	movl	$0x1, 0x8(%rax)
               	movl	$0x1, 0xc(%rax)
               	movq	$0x14, (%rax)
               	leaq	0x10(%rax), %rdi
               	leaq	-0xa8(%rbp), %rax
               	movl	$0x4, %edx
               	leaq	0x4(%rax), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%edx, %edx
               	movl	-0xb0(%rbp), %edi
               	leaq	-0x78(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x1f, %eax
               	leave
               	retq
               	leaq	-0x40(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x78(%rbp), %rsi
               	movq	$0x40, -0x50(%rbp)
               	xorl	%edx, %edx
               	movb	%dl, -0x98(%rbp)
               	movl	-0xac(%rbp), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movsbq	-0x98(%rbp), %rax
               	cmpl	$0x72, %eax
               	je	<addr>
               	movl	$0x20, %eax
               	leave
               	retq
               	movq	-0x50(%rbp), %rax
               	cmpq	$0x10, %rax
               	jb	<addr>
               	movq	-0x58(%rbp), %rax
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
               	leave
               	retq
               	leaq	-0xa0(%rbp), %rdi
               	leaq	0x10(%rax), %rsi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	-0xa0(%rbp), %eax
               	movl	-0xa4(%rbp), %ecx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	-0xa0(%rbp), %edi
               	leaq	<rip>, %rsi
               	movl	$0x1, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movl	-0xa8(%rbp), %edi
               	leaq	-0x90(%rbp), %rsi
               	movl	$0x1, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movsbq	-0x90(%rbp), %rax
               	cmpl	$0x78, %eax
               	je	<addr>
               	movl	$0x22, %eax
               	leave
               	retq
               	movl	-0xa0(%rbp), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	-0xa8(%rbp), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	-0xa4(%rbp), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	-0xb0(%rbp), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	-0xac(%rbp), %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	leave
               	retq

<walk_records>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x88, %rsp
               	pushq	%rbx
               	leaq	-0x40(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x40, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x78(%rbp), %rdi
               	xorl	%esi, %esi
               	movl	$0x38, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x78(%rbp), %rdi
               	leaq	-0x40(%rbp), %rax
               	movq	%rax, -0x58(%rbp)
               	movq	$0x30, -0x50(%rbp)
               	movq	-0x58(%rbp), %rbx
               	cmpq	%rax, %rbx
               	je	<addr>
               	movl	$0x28, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$0x14, (%rbx)
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	-0x40(%rbp), %rax
               	addq	$0x18, %rax
               	cmpq	%rax, %rsi
               	je	<addr>
               	movl	$0x29, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$0x13, (%rsi)
               	leaq	-0x78(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2a, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	0x10(%rbx), %rax
               	leaq	-0x40(%rbp), %rcx
               	addq	$0x10, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x2b, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$0x0, (%rbx)
               	leaq	-0x78(%rbp), %rdi
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2d, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$-0x1, (%rbx)
               	leaq	-0x78(%rbp), %rdi
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2e, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$0xf, -0x50(%rbp)
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
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
               	leave
               	retq
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbx
               	leave
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbx
               	leave
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	popq	%rbx
               	leave
               	retq
               	callq	<addr>
               	popq	%rbx
               	leave
               	retq
