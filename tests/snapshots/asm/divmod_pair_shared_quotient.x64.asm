
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
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdx, %r8
               	movq	%rcx, %r9
               	movl	%edi, %eax
               	movl	%esi, %ecx
               	pushq	%rax
               	xorl	%edx, %edx
               	divq	%rcx
               	movq	%rax, %rdx
               	popq	%rax
               	movl	%r8d, %ebx
               	cmpq	%rbx, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	imulq	%rdx, %rcx
               	subq	%rcx, %rax
               	movl	%r9d, %ebx
               	cmpq	%rbx, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	%edi, %eax
               	movl	%esi, %ecx
               	pushq	%rax
               	xorl	%edx, %edx
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
               	popq	%rbx
               	popq	%r12
               	popq	%r13
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
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	%edi, %eax
               	movl	%esi, %ecx
               	pushq	%rax
               	xorl	%edx, %edx
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
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
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
               	popq	%rbx
               	leave
               	retq
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	movl	$0x7, %esi
               	movl	$0x24924924, %edx       # imm = 0x24924924
               	movl	$0x3, %ecx
               	callq	<addr>
               	movslq	%eax, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	movl	$0xfffffffe, %esi       # imm = 0xFFFFFFFE
               	movl	$0x1, %edx
               	movq	%rdx, %rcx
               	callq	<addr>
               	movslq	%eax, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	xorl	%edi, %edi
               	movl	$0x3, %esi
               	movq	%rdi, %rdx
               	movq	%rdi, %rcx
               	callq	<addr>
               	movslq	%eax, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x34, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x24a0, %eax           # imm = 0x24A0
               	movl	$0xa, %r9d
               	xorl	%ecx, %ecx
               	testl	%eax, %eax
               	jle	<addr>
               	movslq	%eax, %rsi
               	imulq	$0x1999999a, %rsi, %rdi # imm = 0x1999999A
               	movq	%rdi, %r8
               	shrq	$0x20, %r8
               	movq	%r8, %rdx
               	imulq	%r9, %rdx
               	movq	%rdx, %r10
               	movq	%rsi, %rdx
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
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$-0x1, %rax
               	jmp	<addr>
