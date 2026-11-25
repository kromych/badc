
call_alignment_past_saved_registers.x64:	file format elf64-x86-64

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

<aligned_here>:
               	subq	$0x28, %rsp
               	leaq	<rip>, %rdx
               	leaq	(%rsp), %rdi
               	movl	$0x20, %esi
               	movb	$0x1, %al
               	callq	<addr>
               	leaq	(%rsp), %rcx
               	andq	$0xf, %rcx
               	xorl	%edx, %edx
               	cmpl	$0x5, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testl	%ecx, %ecx
               	cmovneq	%rdx, %rax
               	addq	$0x28, %rsp
               	retq

<live1>:
               	pushq	%rax
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movq	%rax, %r12
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	addq	%r12, %rax
               	movslq	%eax, %rax
               	addq	%rbx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r11
               	retq

<live2>:
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movq	%rax, %r13
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	addq	%r13, %rax
               	movslq	%eax, %rax
               	addq	%rbx, %rax
               	addq	%r12, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	retq

<live3>:
               	pushq	%rax
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rdx, %r13
               	movq	%rsi, %r12
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movq	%rax, %r14
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	addq	%r14, %rax
               	movslq	%eax, %rax
               	addq	%rbx, %rax
               	addq	%r12, %rax
               	addq	%r13, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r11
               	retq

<live4>:
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%rcx, %r14
               	movq	%rdx, %r13
               	movq	%rsi, %r12
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movq	%rax, %r15
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	addq	%r15, %rax
               	movslq	%eax, %rax
               	addq	%rbx, %rax
               	addq	%r12, %rax
               	addq	%r13, %rax
               	addq	%r14, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	retq

<live5>:
               	pushq	%rax
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%r8, %r15
               	movq	%rcx, %r14
               	movq	%rdx, %r13
               	movq	%rsi, %r12
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movq	%rax, %rbp
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	addq	%rbp, %rax
               	movslq	%eax, %rax
               	addq	%rbx, %rax
               	addq	%r12, %rax
               	addq	%r13, %rax
               	addq	%r14, %rax
               	addq	%r15, %rax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	popq	%r11
               	retq

<live6>:
               	subq	$0x18, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%r9, %rbp
               	movq	%r8, %r15
               	movq	%rcx, %r14
               	movq	%rdx, %r13
               	movq	%rsi, %r12
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movq	%rax, 0x38(%rsp)
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movq	%rax, %r10
               	movq	0x38(%rsp), %rax
               	addq	%r10, %rax
               	movslq	%eax, %rax
               	addq	%rbx, %rax
               	addq	%r12, %rax
               	addq	%r13, %rax
               	addq	%r14, %rax
               	addq	%r15, %rax
               	addq	%rbp, %rax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x18, %rsp
               	retq

<main>:
               	pushq	%rax
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	callq	<addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	callq	<addr>
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%r11
               	retq
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	movl	$0x4, %ecx
               	callq	<addr>
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%r11
               	retq
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	movl	$0x4, %ecx
               	movl	$0x5, %r8d
               	callq	<addr>
               	cmpq	$0x11, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%r11
               	retq
               	movl	$0x1, %edi
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	movl	$0x4, %ecx
               	movl	$0x5, %r8d
               	movl	$0x6, %r9d
               	callq	<addr>
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
