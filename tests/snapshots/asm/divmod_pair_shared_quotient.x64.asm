
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
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdx, %r8
               	movl	%edi, %r9d
               	movl	%esi, %eax
               	movq	%rax, %r10
               	pushq	%rax
               	movq	%r9, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	movq	%rax, %rdx
               	popq	%rax
               	cmpl	%r8d, %edx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	imulq	%rdx, %rax
               	movq	%r9, %rdx
               	subq	%rax, %rdx
               	movl	%ecx, %eax
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	%edi, %r9d
               	movl	%esi, %edx
               	movq	%rdx, %r10
               	pushq	%rdx
               	movq	%r9, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	popq	%rdx
               	imulq	%rax, %rdx
               	movq	%r9, %rbx
               	subq	%rdx, %rbx
               	addq	%rax, %rbx
               	leaq	(%r8,%rcx), %r12
               	cmpl	%r12d, %ebx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	subq	%rdx, %r9
               	addq	%r9, %rax
               	addq	%r8, %rcx
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movl	%edi, %ecx
               	movl	%esi, %esi
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	imulq	%rsi, %rax
               	movq	%rcx, %rdx
               	subq	%rax, %rdx
               	addq	%rdx, %rax
               	cmpl	%ecx, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rax
               	movq	%rcx, %rdx
               	shlq	$0x4, %rdx
               	addq	%rdx, %rax
               	movslq	(%rax), %rsi
               	movslq	0x4(%rax), %r8
               	movslq	0x8(%rax), %r9
               	movslq	0xc(%rax), %rax
               	pushq	%rax
               	movq	%rsi, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %rdi
               	popq	%rax
               	cmpq	%r9, %rdi
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	movq	%rdi, %rdx
               	imulq	%r8, %rdx
               	negq	%rdx
               	addq	%rsi, %rdx
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	addq	%rdi, %rdx
               	addq	%rax, %r9
               	cmpl	%r9d, %edx
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	imulq	%rdi, %r8
               	movq	%rsi, %rax
               	subq	%r8, %rax
               	addq	%rdi, %rax
               	cmpl	%r9d, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movq	%rsi, %rax
               	subq	%r8, %rax
               	addq	%r8, %rax
               	cmpl	%esi, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	incq	%rcx
               	cmpl	$0xc, %ecx
               	jb	<addr>
               	movl	$0x11, %edi
               	movl	$0x5, %esi
               	movl	$0x3, %edx
               	movl	$0x2, %ecx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	addq	$0x1e, %rax
               	popq	%rbx
               	leave
               	retq
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	movl	$0x7, %esi
               	movl	$0x24924924, %edx       # imm = 0x24924924
               	movl	$0x3, %ecx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	movl	$0xfffffffe, %esi       # imm = 0xFFFFFFFE
               	movl	$0x1, %edx
               	movq	%rdx, %rcx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%edi, %edi
               	movl	$0x3, %esi
               	movq	%rdi, %rdx
               	movq	%rdi, %rcx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movq	%rcx, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x34, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x24a0, %eax           # imm = 0x24A0
               	movl	$0xa, %esi
               	xorl	%ecx, %ecx
               	imulq	$0x1999999a, %rax, %rdx # imm = 0x1999999A
               	shrq	$0x20, %rdx
               	movq	%rdx, %rdi
               	imulq	%rsi, %rdi
               	subq	%rdi, %rax
               	cmpl	$0x64, %eax
               	jg	<addr>
               	addq	%rax, %rcx
               	movq	%rdx, %rax
               	testl	%eax, %eax
               	jg	<addr>
               	cmpl	$0x19, %ecx
               	je	<addr>
               	movl	$0x35, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	addq	$0xa, %rax
               	popq	%rbx
               	leave
               	retq
