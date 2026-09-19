
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
               	movl	%edi, %eax
               	movl	%esi, %r8d
               	pushq	%rax
               	pushq	%rdx
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	cmpl	%edx, %r9d
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	imulq	%r9, %r8
               	subq	%r8, %rax
               	movl	%ecx, %r8d
               	cmpq	%r8, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	%edi, %eax
               	movl	%esi, %r8d
               	pushq	%rax
               	pushq	%rdx
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rax, %r9
               	popq	%rdx
               	popq	%rax
               	movq	%r9, %rbx
               	imulq	%r8, %rbx
               	movq	%rax, %r12
               	subq	%rbx, %r12
               	addq	%r9, %r12
               	leaq	(%rdx,%rcx), %r13
               	cmpl	%r13d, %r12d
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	subq	%rbx, %rax
               	addq	%r9, %rax
               	addq	%rdx, %rcx
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
               	movq	%rax, %rdx
               	subq	%rcx, %rdx
               	addq	%rdx, %rcx
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
               	popq	%rbp
               	retq
               	movl	$0x24a0, %eax           # imm = 0x24A0
               	movl	$0xa, %r8d
               	xorl	%ecx, %ecx
               	testl	%eax, %eax
               	jle	<addr>
               	imulq	$0x1999999a, %rax, %rsi # imm = 0x1999999A
               	movq	%rsi, %rdi
               	shrq	$0x20, %rdi
               	movq	%rdi, %r9
               	imulq	%r8, %r9
               	movq	%rax, %rdx
               	subq	%r9, %rdx
               	cmpl	$0x64, %edx
               	jg	<addr>
               	addq	%rdx, %rcx
               	movq	%rdi, %rax
               	testl	%eax, %eax
               	jg	<addr>
               	cmpl	$0x19, %ecx
               	je	<addr>
               	movl	$0x35, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	movq	$-0x1, %rcx
               	jmp	<addr>
