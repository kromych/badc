
address_retested_after_calls.x64:	file format elf64-x86-64

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

<movable>:
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movq	(%rdi), %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	retq

<enable>:
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	retq

<report>:
               	cmpl	$0x40, %edi
               	jne	<addr>
               	testq	%rsi, %rsi
               	je	<addr>
               	cmpq	$0x0, (%rsi)
               	jne	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>

<check>:
               	pushq	%rax
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	callq	<addr>
               	movl	$0x40, %edi
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx # <addr>
               	testq	%rcx, %rcx
               	cmoveq	%rax, %rdi
               	xorl	%eax, %eax
               	leaq	<rip>, %rsi # <addr>
               	testq	%rsi, %rsi
               	cmoveq	%rax, %rsi
               	popq	%r11
               	jmp	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq

<main>:
               	subq	$0x18, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbp
               	pushq	%rbx
               	movq	<rip>, %rbx # <addr>
               	movq	<rip>, %r12 # <addr>
               	movq	<rip>, %r13 # <addr>
               	movq	<rip>, %r14 # <addr>
               	movq	<rip>, %r15 # <addr>
               	movq	<rip>, %rbp # <addr>
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x38(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x30(%rsp)
               	callq	<addr>
               	leaq	(%rbx,%r12), %rcx
               	addq	%r13, %rcx
               	addq	%r14, %rcx
               	addq	%r15, %rcx
               	addq	%rbp, %rcx
               	addq	0x38(%rsp), %rcx
               	addq	0x30(%rsp), %rcx
               	addq	%rcx, %rax
               	xorl	%ecx, %ecx
               	movl	$0x4, %edx
               	movl	<rip>, %esi # <addr>
               	cmpl	$0x2, %esi
               	cmovneq	%rdx, %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%rbp
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	addq	$0x18, %rsp
               	retq
