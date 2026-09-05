
divmod_pair_shared_quotient.x64:	file format elf64-x86-64

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

<check_uint>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	movl	%edi, %eax
               	movl	%esi, %ecx
               	pushq	%rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rax, %rdx
               	popq	%rax
               	movl	%r8d, %ebx
               	cmpq	%rbx, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	imulq	%rdx, %rcx
               	subq	%rcx, %rax
               	movl	%r9d, %ebx
               	cmpq	%rbx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	%edi, %eax
               	movl	%esi, %ecx
               	pushq	%rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rax, %rdx
               	popq	%rax
               	movq	%rdx, %r12
               	imulq	%rcx, %r12
               	movq	%r12, %r10
               	movq	%rax, %r12
               	subq	%r10, %r12
               	addq	%rdx, %r12
               	movl	%r12d, %r12d
               	movl	%r8d, %r13d
               	addq	%r13, %rbx
               	movl	%ebx, %ebx
               	cmpl	%ebx, %r12d
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	imulq	%rdx, %rcx
               	subq	%rcx, %rax
               	addq	%rdx, %rax
               	movl	%eax, %eax
               	movl	%r8d, %ecx
               	movl	%r9d, %edx
               	addq	%rdx, %rcx
               	movl	%ecx, %ecx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	movl	%edi, %eax
               	movl	%esi, %ecx
               	pushq	%rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rax, %rdx
               	popq	%rax
               	imulq	%rdx, %rcx
               	movl	%ecx, %edx
               	movq	%rcx, %r10
               	movq	%rax, %rcx
               	subq	%r10, %rcx
               	addq	%rdx, %rcx
               	movl	%ecx, %ecx
               	cmpl	%eax, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movq	%rcx, %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movq	%rcx, %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movq	%rcx, %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movq	%rcx, %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movq	%rcx, %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movq	%rcx, %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movl	$0x11, %edi
               	movl	$0x5, %esi
               	movl	$0x3, %edx
               	movl	$0x2, %ecx
               	callq	<addr>
               	movslq	%eax, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	addq	$0x1e, %rax
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	movl	$0x7, %esi
               	movl	$0x24924924, %edx       # imm = 0x24924924
               	movl	$0x3, %ecx
               	callq	<addr>
               	movslq	%eax, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	movl	$0xfffffffe, %esi       # imm = 0xFFFFFFFE
               	movl	$0x1, %edx
               	movq	%rdx, %rcx
               	callq	<addr>
               	movslq	%eax, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	movl	$0x3, %esi
               	movq	%rdi, %rdx
               	movq	%rdi, %rcx
               	callq	<addr>
               	movslq	%eax, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	movq	%rcx, %rax
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x34, %eax
               	popq	%rbp
               	retq
               	movl	$0x24a0, %eax           # imm = 0x24A0
               	movl	$0xa, %esi
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%eax, %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	%r8, %rdx
               	imulq	%rsi, %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	cmpl	$0x64, %edx
               	jg	<addr>
               	addq	%rdx, %rcx
               	movq	%r8, %rax
               	testl	%eax, %eax
               	jg	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x19, %rax
               	je	<addr>
               	movl	$0x35, %eax
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rax
               	movl	$0xa, %esi
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%eax, %rdi
               	pushq	%rax
               	pushq	%rdx
               	movq	%rdi, %rax
               	cqto
               	idivq	%rsi
               	movq	%rax, %r8
               	popq	%rdx
               	popq	%rax
               	movq	%r8, %rdx
               	imulq	%rsi, %rdx
               	movq	%rdx, %r10
               	movq	%rdi, %rdx
               	subq	%r10, %rdx
               	cmpl	$0x64, %edx
               	jg	<addr>
               	addq	%rdx, %rcx
               	movq	%r8, %rax
               	testl	%eax, %eax
               	jg	<addr>
               	movslq	%ecx, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x36, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	movabsq	$-0x1, %rax
               	jmp	<addr>
               	movabsq	$-0x1, %rax
               	jmp	<addr>
