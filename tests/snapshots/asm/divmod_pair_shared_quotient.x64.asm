
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
               	movl	$0x11, %edi
               	movl	$0x5, %esi
               	movl	$0x3, %edx
               	movl	$0x2, %ecx
               	callq	<addr>
               	testl	%eax, %eax
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
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	movl	$0xfffffffe, %esi       # imm = 0xFFFFFFFE
               	movl	$0x1, %edx
               	movq	%rdx, %rcx
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	xorl	%edi, %edi
               	movl	$0x3, %esi
               	movq	%rdi, %rdx
               	movq	%rdi, %rcx
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movq	%rcx, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x34, %eax
               	popq	%rbp
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
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	movq	$-0x1, %rcx
               	jmp	<addr>
