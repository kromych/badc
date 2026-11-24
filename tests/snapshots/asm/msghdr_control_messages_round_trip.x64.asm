
msghdr_control_messages_round_trip.x64:	file format elf64-x86-64

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

<ipv6_pktinfo>:
               	subq	$0x100, %rsp            # imm = 0x100
               	pushq	%rbx
               	movl	$0x1c, 0x28(%rsp)
               	movb	$0x36, 0x30(%rsp)
               	movl	$0x1, 0x38(%rsp)
               	xorl	%edx, %edx
               	movl	$0xa, %edi
               	movl	$0x2, %esi
               	callq	<addr>
               	movq	%rax, %rbx
               	testl	%ebx, %ebx
               	jge	<addr>
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x14, %edx
               	movl	(%rax), %eax
               	cmpl	$0x61, %eax
               	cmovneq	%rdx, %rcx
               	movq	%rcx, %rax
               	popq	%rbx
               	addq	$0x100, %rsp            # imm = 0x100
               	retq
               	leaq	0x68(%rsp), %rsi
               	movq	$0x0, 0x70(%rsp)
               	movabsq	$0x100000000000000, %rdx # imm = 0x100000000000000
               	movl	$0x0, 0x80(%rsp)
               	movq	$0xa, 0x68(%rsp)
               	movq	%rdx, 0x78(%rsp)
               	movl	$0x1c, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	callq	<addr>
               	xorl	%ecx, %ecx
               	movl	$0x15, %edx
               	movl	(%rax), %eax
               	cmpl	$0x63, %eax
               	cmovneq	%rdx, %rcx
               	movq	%rcx, %rax
               	popq	%rbx
               	addq	$0x100, %rsp            # imm = 0x100
               	retq
               	leaq	0x68(%rsp), %rsi
               	leaq	0x28(%rsp), %rdx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	popq	%rbx
               	addq	$0x100, %rsp            # imm = 0x100
               	retq
               	movl	$0x29, %esi
               	movl	$0x31, %edx
               	leaq	0x38(%rsp), %rcx
               	movl	$0x4, %r8d
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x17, %eax
               	popq	%rbx
               	addq	$0x100, %rsp            # imm = 0x100
               	retq
               	leaq	0x30(%rsp), %rsi
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	leaq	0x68(%rsp), %r8
               	movl	$0x1c, %r9d
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x18, %eax
               	popq	%rbx
               	addq	$0x100, %rsp            # imm = 0x100
               	retq
               	leaq	0x30(%rsp), %rax
               	movq	%rax, 0x40(%rsp)
               	movq	$0x1, 0x48(%rsp)
               	xorl	%edx, %edx
               	movq	%rdx, 0x88(%rsp)
               	movq	%rdx, 0x90(%rsp)
               	movq	%rdx, 0xb8(%rsp)
               	leaq	0x40(%rsp), %rcx
               	movq	%rcx, 0x98(%rsp)
               	leaq	0x88(%rsp), %rsi
               	movq	$0x1, 0xa0(%rsp)
               	leaq	0xc0(%rsp), %rax
               	movq	%rax, 0xa8(%rsp)
               	movq	$0x40, 0xb0(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movsbq	0x30(%rsp), %rax
               	cmpl	$0x36, %eax
               	je	<addr>
               	movl	$0x19, %eax
               	popq	%rbx
               	addq	$0x100, %rsp            # imm = 0x100
               	retq
               	movq	0xb0(%rsp), %rax
               	cmpq	$0x10, %rax
               	jb	<addr>
               	movq	0xa8(%rsp), %rax
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	leaq	0x88(%rsp), %rdi
               	movq	%rcx, 0x18(%rsp)
               	movq	%rax, %rsi
               	callq	<addr>
               	movq	0x18(%rsp), %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movl	0x8(%rax), %edx
               	cmpl	$0x29, %edx
               	jne	<addr>
               	movl	0xc(%rax), %edx
               	cmpl	$0x32, %edx
               	jne	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x24, %rcx
               	jne	<addr>
               	leaq	0x50(%rsp), %rcx
               	leaq	0x10(%rax), %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movl	0x10(%rdx), %r10d
               	movl	%r10d, 0x10(%rcx)
               	xorl	%edx, %edx
               	movl	0x10(%rax), %ecx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	0x14(%rax), %ecx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	0x58(%rsp), %ecx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movzbq	0x5c(%rsp), %rcx
               	testl	%ecx, %ecx
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorl	%ecx, %ecx
               	testq	%rdx, %rdx
               	je	<addr>
               	movzbq	0x5d(%rsp), %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movzbq	0x5e(%rsp), %rdx
               	testl	%edx, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movzbq	0x5f(%rsp), %rdx
               	cmpl	$0x1, %edx
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	0x60(%rsp), %ecx
               	testl	%ecx, %ecx
               	seta	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	movq	%rdx, %rcx
               	jmp	<addr>
               	movl	$0x1a, %eax
               	popq	%rbx
               	addq	$0x100, %rsp            # imm = 0x100
               	retq
               	movq	%rcx, 0x18(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	0x18(%rsp), %rcx
               	xorl	%eax, %eax
               	movl	$0x1b, %edx
               	testq	%rcx, %rcx
               	cmoveq	%rdx, %rax
               	popq	%rbx
               	addq	$0x100, %rsp            # imm = 0x100
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>

<main>:
               	subq	$0x118, %rsp            # imm = 0x118
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	xorl	%edx, %edx
               	callq	<addr>
               	movq	%rax, %rcx
               	testl	%ecx, %ecx
               	jl	<addr>
               	movq	%rcx, 0x8(%rsp)
               	movq	%rcx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	0x8(%rsp), %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x118, %rsp            # imm = 0x118
               	retq
               	movq	%rcx, %rdi
               	callq	<addr>
               	movl	$0x10, 0x28(%rsp)
               	movl	$0x1, 0x40(%rsp)
               	xorl	%edx, %edx
               	movl	$0x2, %edi
               	movq	%rdi, %rsi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	movq	$0x0, 0x50(%rsp)
               	movq	$0x2, 0x48(%rsp)
               	movl	$0x7f000001, %edi       # imm = 0x7F000001
               	callq	<addr>
               	movl	%eax, 0x4c(%rsp)
               	movq	0x18(%rsp), %rax
               	testl	%eax, %eax
               	jl	<addr>
               	leaq	0x48(%rsp), %rsi
               	movl	$0x10, %edx
               	movq	0x18(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	testl	%eax, %eax
               	je	<addr>
               	addq	$0x118, %rsp            # imm = 0x118
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	addq	$0x118, %rsp            # imm = 0x118
               	retq
               	movl	$0xffffffff, 0x50(%rsp) # imm = 0xFFFFFFFF
               	movb	$0x72, 0x60(%rsp)
               	xorl	%edx, %edx
               	movb	%dl, 0x70(%rsp)
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	leaq	0x38(%rsp), %rcx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x40(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1e, %eax
               	testl	%eax, %eax
               	je	<addr>
               	addq	$0x118, %rsp            # imm = 0x118
               	retq
               	leaq	0xd0(%rsp), %rsi
               	movq	$0x0, 0xd0(%rsp)
               	movq	$0x0, 0xd8(%rsp)
               	movq	$0x0, 0xe0(%rsp)
               	movq	$0x0, 0xe8(%rsp)
               	movq	$0x0, 0xf0(%rsp)
               	movq	$0x0, 0xf8(%rsp)
               	movq	$0x0, 0x100(%rsp)
               	movq	$0x0, 0x108(%rsp)
               	leaq	0x98(%rsp), %rdi
               	movq	$0x0, 0x98(%rsp)
               	movq	$0x0, 0xa0(%rsp)
               	movq	$0x0, 0xa8(%rsp)
               	movq	$0x0, 0xb0(%rsp)
               	movq	$0x0, 0xc8(%rsp)
               	movq	%rsi, 0xb8(%rsp)
               	movq	$0x30, 0xc0(%rsp)
               	movq	$0x14, (%rsi)
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	0xd0(%rsp), %rax
               	addq	$0x18, %rax
               	cmpq	%rax, %rsi
               	je	<addr>
               	movl	$0x29, %eax
               	addq	$0x118, %rsp            # imm = 0x118
               	retq
               	movq	$0x13, (%rsi)
               	leaq	0x98(%rsp), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2a, %eax
               	jmp	<addr>
               	leaq	0xd0(%rsp), %rax
               	addq	$0x10, %rax
               	leaq	0xd0(%rsp), %rcx
               	addq	$0x10, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x2b, %eax
               	jmp	<addr>
               	leaq	0xd0(%rsp), %rsi
               	movq	$0x0, (%rsi)
               	leaq	0x98(%rsp), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2d, %eax
               	jmp	<addr>
               	leaq	0xd0(%rsp), %rsi
               	movq	$-0x1, (%rsi)
               	leaq	0x98(%rsp), %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2e, %eax
               	jmp	<addr>
               	movq	$0xf, 0xc0(%rsp)
               	xorl	%eax, %eax
               	jmp	<addr>
               	leaq	0x88(%rsp), %rsi
               	leaq	0x60(%rsp), %rax
               	movq	%rax, 0x88(%rsp)
               	movq	$0x1, 0x90(%rsp)
               	movq	$0x0, 0x98(%rsp)
               	movq	$0x0, 0xa0(%rsp)
               	movq	$0x0, 0xc8(%rsp)
               	leaq	0xd0(%rsp), %rcx
               	movq	$0x0, 0xd0(%rsp)
               	movq	$0x0, 0xd8(%rsp)
               	movq	$0x0, 0xe0(%rsp)
               	movq	$0x0, 0xe8(%rsp)
               	movq	$0x0, 0xf0(%rsp)
               	movq	$0x0, 0xf8(%rsp)
               	movq	$0x0, 0x100(%rsp)
               	movq	$0x0, 0x108(%rsp)
               	movq	%rsi, 0xa8(%rsp)
               	movq	$0x1, 0xb0(%rsp)
               	movq	%rcx, 0xb8(%rsp)
               	leaq	0x98(%rsp), %rsi
               	movq	$0x18, 0xc0(%rsp)
               	movabsq	$0x100000001, %rax      # imm = 0x100000001
               	movq	%rax, 0x8(%rcx)
               	movq	$0x14, (%rcx)
               	leaq	0x10(%rcx), %rax
               	leaq	0x40(%rsp), %rcx
               	addq	$0x4, %rcx
               	movl	(%rcx), %r10d
               	movl	%r10d, (%rax)
               	xorl	%edx, %edx
               	movl	0x38(%rsp), %edi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x1f, %eax
               	jmp	<addr>
               	xorl	%edx, %edx
               	movq	%rdx, 0xd0(%rsp)
               	movq	%rdx, 0xd8(%rsp)
               	movq	%rdx, 0xe0(%rsp)
               	movq	%rdx, 0xe8(%rsp)
               	movq	%rdx, 0xf0(%rsp)
               	movq	%rdx, 0xf8(%rsp)
               	movq	%rdx, 0x100(%rsp)
               	movq	%rdx, 0x108(%rsp)
               	leaq	0x98(%rsp), %rsi
               	movq	$0x40, 0xc0(%rsp)
               	movb	%dl, 0x60(%rsp)
               	movl	0x3c(%rsp), %edi
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movsbq	0x60(%rsp), %rax
               	cmpl	$0x72, %eax
               	je	<addr>
               	movl	$0x20, %eax
               	jmp	<addr>
               	movq	0xc0(%rsp), %rax
               	cmpq	$0x10, %rax
               	jb	<addr>
               	movq	0xb8(%rsp), %rax
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
               	leaq	0x50(%rsp), %rcx
               	leaq	0x10(%rax), %rdx
               	movl	(%rdx), %r10d
               	movl	%r10d, (%rcx)
               	movl	0x10(%rax), %edi
               	movl	0x44(%rsp), %eax
               	cmpl	%eax, %edi
               	je	<addr>
               	leaq	<rip>, %rsi
               	movl	$0x1, %edx
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movl	0x40(%rsp), %edi
               	leaq	0x70(%rsp), %rsi
               	movl	$0x1, %edx
               	callq	<addr>
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movsbq	0x70(%rsp), %rax
               	cmpl	$0x78, %eax
               	je	<addr>
               	movl	$0x22, %eax
               	jmp	<addr>
               	movl	0x50(%rsp), %edi
               	callq	<addr>
               	movl	0x40(%rsp), %edi
               	callq	<addr>
               	movl	0x44(%rsp), %edi
               	callq	<addr>
               	movl	0x38(%rsp), %edi
               	callq	<addr>
               	movl	0x3c(%rsp), %edi
               	callq	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	leaq	0x48(%rsp), %rsi
               	leaq	0x28(%rsp), %rdx
               	movq	0x18(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	jmp	<addr>
               	xorl	%esi, %esi
               	movl	$0x8, %edx
               	leaq	0x40(%rsp), %rcx
               	movl	$0x4, %r8d
               	movq	0x18(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	jmp	<addr>
               	xorl	%edx, %edx
               	leaq	<rip>, %rax
               	movq	%rax, 0x78(%rsp)
               	movq	$0x3, 0x80(%rsp)
               	leaq	<rip>, %rax
               	movq	%rax, 0x88(%rsp)
               	movq	$0x5, 0x90(%rsp)
               	movq	$0x0, 0xb8(%rsp)
               	movq	$0x0, 0xc0(%rsp)
               	movq	$0x0, 0xc8(%rsp)
               	leaq	0x48(%rsp), %rax
               	movq	%rax, 0x98(%rsp)
               	movq	$0x10, 0xa0(%rsp)
               	leaq	0x98(%rsp), %rsi
               	leaq	0x78(%rsp), %rax
               	movq	%rax, 0xa8(%rsp)
               	movq	$0x2, 0xb0(%rsp)
               	movq	0x18(%rsp), %rdi
               	callq	<addr>
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	jmp	<addr>
               	xorl	%edx, %edx
               	leaq	0x30(%rsp), %rax
               	movq	%rax, 0x78(%rsp)
               	movq	$0x4, 0x80(%rsp)
               	leaq	0x38(%rsp), %rax
               	movq	%rax, 0x88(%rsp)
               	movq	$0x8, 0x90(%rsp)
               	movq	$0x0, 0xc8(%rsp)
               	leaq	0x58(%rsp), %rax
               	movq	$0x0, 0x58(%rsp)
               	movq	$0x0, 0x60(%rsp)
               	movq	%rax, 0x98(%rsp)
               	movq	$0x10, 0xa0(%rsp)
               	leaq	0x78(%rsp), %rax
               	movq	%rax, 0xa8(%rsp)
               	movq	$0x2, 0xb0(%rsp)
               	leaq	0xd0(%rsp), %rax
               	movq	%rax, 0xb8(%rsp)
               	movq	$0x40, 0xc0(%rsp)
               	leaq	0x98(%rsp), %rsi
               	movq	0x18(%rsp), %rdi
               	callq	<addr>
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	jmp	<addr>
               	leaq	0x30(%rsp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x38(%rsp), %rdi
               	leaq	<rip>, %rsi
               	movl	$0x4, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	jmp	<addr>
               	movl	0xa0(%rsp), %eax
               	cmpl	$0x10, %eax
               	jne	<addr>
               	movzwq	0x5a(%rsp), %rax
               	movzwq	0x4a(%rsp), %rcx
               	cmpl	%ecx, %eax
               	jne	<addr>
               	movl	0x5c(%rsp), %r10d
               	movq	%r10, 0x10(%rsp)
               	movl	$0x7f000001, %edi       # imm = 0x7F000001
               	callq	<addr>
               	movl	%eax, %eax
               	movq	%rax, %r10
               	movq	0x10(%rsp), %rax
               	cmpq	%r10, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	jmp	<addr>
               	movl	0xc8(%rsp), %eax
               	testb	$0x28, %al
               	je	<addr>
               	movl	$0x11, %eax
               	jmp	<addr>
               	movq	0xc0(%rsp), %rax
               	cmpq	$0x10, %rax
               	jb	<addr>
               	movq	0xb8(%rsp), %rcx
               	xorl	%edx, %edx
               	jmp	<addr>
               	leaq	0x98(%rsp), %rdi
               	movq	%rdx, 0x8(%rsp)
               	movq	%rcx, %rsi
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	0x8(%rsp), %rdx
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpl	$0x0, 0x8(%rcx)
               	jne	<addr>
               	movl	0xc(%rcx), %eax
               	cmpl	$0x8, %eax
               	jne	<addr>
               	movq	(%rcx), %rax
               	cmpq	$0x1c, %rax
               	jne	<addr>
               	leaq	0x68(%rsp), %rax
               	leaq	0x10(%rcx), %rdx
               	movq	(%rdx), %r10
               	movq	%r10, (%rax)
               	movl	0x8(%rdx), %r10d
               	movl	%r10d, 0x8(%rax)
               	movl	0x18(%rcx), %r10d
               	movq	%r10, 0x10(%rsp)
               	movl	$0x7f000001, %edi       # imm = 0x7F000001
               	movq	%rcx, 0x8(%rsp)
               	callq	<addr>
               	movl	%eax, %eax
               	movq	0x8(%rsp), %rcx
               	movq	%rax, %r10
               	movq	0x10(%rsp), %rax
               	cmpq	%r10, %rax
               	sete	%al
               	movzbq	%al, %rax
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	je	<addr>
               	movl	0x68(%rsp), %eax
               	testl	%eax, %eax
               	setg	%dl
               	movzbq	%dl, %rdx
               	jmp	<addr>
               	movl	$0x12, %eax
               	jmp	<addr>
               	movq	%rdx, 0x8(%rsp)
               	movq	0x18(%rsp), %rdi
               	callq	<addr>
               	movq	0x8(%rsp), %rdx
               	xorl	%eax, %eax
               	movl	$0x13, %ecx
               	testq	%rdx, %rdx
               	cmoveq	%rcx, %rax
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
