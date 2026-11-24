
pthread_rwlock_spin_barrier_and_attributes.x64:	file format elf64-x86-64

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

<reader>:
               	subq	$0x18, %rsp
               	testq	%rdi, %rdi
               	je	<addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	xorl	%ecx, %ecx
               	movl	$0x3, %edx
               	cmpq	$0x10, %rax
               	cmovneq	%rdx, %rcx
               	movq	%rcx, %rax
               	addq	$0x18, %rsp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
               	retq
               	movl	<rip>, %r10d # <addr>
               	movq	%r10, 0x8(%rsp)
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	xorl	%eax, %eax
               	movl	$0x2, %ecx
               	movq	0x8(%rsp), %rdx
               	cmpl	$0x7, %edx
               	cmovneq	%rcx, %rax
               	addq	$0x18, %rsp
               	retq

<reentrant>:
               	subq	$0x1a0, %rsp            # imm = 0x1A0
               	pushq	%rbx
               	movl	$0x5, 0x18(%rsp)
               	movl	$0x5, 0x20(%rsp)
               	movq	$0x0, 0x28(%rsp)
               	leaq	0x18(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	leaq	0x20(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	%rax, %rbx
               	jne	<addr>
               	movl	0x18(%rsp), %eax
               	movl	0x20(%rsp), %ecx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x14, %eax
               	popq	%rbx
               	addq	$0x1a0, %rsp            # imm = 0x1A0
               	retq
               	leaq	0x50(%rsp), %rdi
               	movq	$0x0, 0x50(%rsp)
               	movabsq	$0x100000000, %rcx      # imm = 0x100000000
               	movabsq	$0x4600000000, %rdx     # imm = 0x4600000000
               	movq	$0x0, 0x70(%rsp)
               	movq	$0x0, 0x78(%rsp)
               	movq	$0x0, 0x80(%rsp)
               	movq	%rdx, 0x60(%rsp)
               	movq	%rcx, 0x58(%rsp)
               	movq	$0x4, 0x68(%rsp)
               	leaq	0x30(%rsp), %rsi
               	callq	<addr>
               	leaq	0x30(%rsp), %rdi
               	cmpq	%rdi, %rax
               	jne	<addr>
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x15, %eax
               	popq	%rbx
               	addq	$0x1a0, %rsp            # imm = 0x1A0
               	retq
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rax, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	0x88(%rsp), %rsi
               	leaq	0x28(%rsp), %rdx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x28(%rsp), %rax
               	leaq	0x88(%rsp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	popq	%rbx
               	addq	$0x1a0, %rsp            # imm = 0x1A0
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x1a0, %rsp            # imm = 0x1A0
               	retq

<linux_only>:
               	subq	$0x168, %rsp            # imm = 0x168
               	leaq	0x30(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movl	$0xffffffff, 0x28(%rsp) # imm = 0xFFFFFFFF
               	leaq	0x10(%rsp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x10(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1f, %eax
               	addq	$0x168, %rsp            # imm = 0x168
               	retq
               	leaq	0x10(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x10, %rax
               	jne	<addr>
               	leaq	0x10(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x20, %eax
               	addq	$0x168, %rsp            # imm = 0x168
               	retq
               	leaq	0x10(%rsp), %rdi
               	callq	<addr>
               	leaq	0x40(%rsp), %rdi
               	xorl	%esi, %esi
               	movl	$0x1, %edx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x21, %eax
               	addq	$0x168, %rsp            # imm = 0x168
               	retq
               	leaq	0x40(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x22, %eax
               	addq	$0x168, %rsp            # imm = 0x168
               	retq
               	leaq	0x40(%rsp), %rdi
               	callq	<addr>
               	leaq	0x18(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x18(%rsp), %rdi
               	movl	$0x1, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x18(%rsp), %rdi
               	leaq	0x28(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	0x28(%rsp), %eax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x23, %eax
               	addq	$0x168, %rsp            # imm = 0x168
               	retq
               	leaq	0x18(%rsp), %rdi
               	callq	<addr>
               	xorl	%edi, %edi
               	leaq	0x20(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	0x20(%rsp), %edi
               	leaq	0x30(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x24, %eax
               	addq	$0x168, %rsp            # imm = 0x168
               	retq
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x20, %rax
               	jl	<addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	%r10, 0x8(%rsp)
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	0x8(%rsp), %rax
               	cmpq	%r10, %rax
               	jg	<addr>
               	movl	$0x25, %eax
               	addq	$0x168, %rsp            # imm = 0x168
               	retq
               	leaq	0x60(%rsp), %rdi
               	callq	<addr>
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	0x60(%rsp), %rdi
               	callq	<addr>
               	xorl	%edi, %edi
               	leaq	0x60(%rsp), %rsi
               	movq	%rdi, %rdx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x26, %eax
               	addq	$0x168, %rsp            # imm = 0x168
               	retq
               	movl	$0x2a, 0x158(%rsp)
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x8(%rsp)
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	0x158(%rsp), %rdx
               	movq	0x8(%rsp), %rdi
               	movq	(%rdx), %rdx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x27, %eax
               	addq	$0x168, %rsp            # imm = 0x168
               	retq
               	leaq	0x30(%rsp), %rdx
               	movq	$0x5, 0x30(%rsp)
               	movq	$0x0, 0x38(%rsp)
               	leaq	0x60(%rsp), %rdi
               	leaq	0xe0(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	%r10, 0x8(%rsp)
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	0x8(%rsp), %rax
               	cmpq	%r10, %rax
               	jne	<addr>
               	movl	0xf8(%rsp), %eax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x28, %eax
               	addq	$0x168, %rsp            # imm = 0x168
               	retq
               	xorl	%eax, %eax
               	addq	$0x168, %rsp            # imm = 0x168
               	retq

<main>:
               	subq	$0x68, %rsp
               	movl	$0xffffffff, 0x20(%rsp) # imm = 0xFFFFFFFF
               	movl	$0x7, <rip> # <addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x10, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	movq	$0x0, 0x10(%rsp)
               	movl	$0xffffffff, 0x18(%rsp) # imm = 0xFFFFFFFF
               	movl	$0xffffffff, 0x20(%rsp) # imm = 0xFFFFFFFF
               	leaq	0x28(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x28(%rsp), %rdi
               	movl	$0x100000, %esi         # imm = 0x100000
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	callq	<addr>
               	addq	$0x68, %rsp
               	retq
               	leaq	0x28(%rsp), %rdi
               	leaq	0x10(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x10(%rsp), %rax
               	cmpq	$0x100000, %rax         # imm = 0x100000
               	je	<addr>
               	movl	$0xb, %eax
               	jmp	<addr>
               	leaq	0x28(%rsp), %rdi
               	leaq	0x18(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x0, 0x18(%rsp)
               	je	<addr>
               	movl	$0xc, %eax
               	jmp	<addr>
               	leaq	0x28(%rsp), %rdi
               	callq	<addr>
               	leaq	0x8(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	jmp	<addr>
               	leaq	0x8(%rsp), %rdi
               	movl	$0x1, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x8(%rsp), %rdi
               	leaq	0x18(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	0x18(%rsp), %eax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0xe, %eax
               	jmp	<addr>
               	leaq	0x8(%rsp), %rdi
               	leaq	0x18(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x0, 0x18(%rsp)
               	je	<addr>
               	movl	$0xf, %eax
               	jmp	<addr>
               	leaq	0x8(%rsp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x8(%rsp), %rdi
               	leaq	0x18(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x0, 0x18(%rsp)
               	je	<addr>
               	movl	$0x10, %eax
               	jmp	<addr>
               	leaq	0x8(%rsp), %rdi
               	callq	<addr>
               	movl	$0x1, %edi
               	leaq	0x20(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	0x20(%rsp), %edi
               	testl	%edi, %edi
               	je	<addr>
               	movl	$0x11, %eax
               	jmp	<addr>
               	leaq	0x18(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	0x18(%rsp), %eax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x12, %eax
               	jmp	<addr>
               	callq	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	leaq	0x10(%rsp), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx # <addr>
               	movq	%rsi, %rcx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x10(%rsp), %rdi
               	leaq	0x18(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0x0, 0x18(%rsp)
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	leaq	0x10(%rsp), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx # <addr>
               	movq	%rdi, %rcx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x10(%rsp), %rdi
               	leaq	0x18(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpq	$0x0, 0x18(%rsp)
               	je	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	jmp	<addr>
               	leaq	0x8(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	jmp	<addr>
               	leaq	0x8(%rsp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x8(%rsp), %rdi
               	leaq	0x20(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	cmpl	$0x0, 0x20(%rsp)
               	je	<addr>
               	movl	$0x7, %eax
               	jmp	<addr>
               	leaq	0x28(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x28(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x28(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x28(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	jmp	<addr>
               	leaq	0x8(%rsp), %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
