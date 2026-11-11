
address_retested_after_calls.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	callq	<addr>
               	movl	$0x40, %eax
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rdx # <addr>
               	testq	%rdx, %rdx
               	movq	%rcx, %rdi
               	cmovneq	%rax, %rdi
               	xorl	%ecx, %ecx
               	leaq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	movq	%rcx, %rsi
               	cmovneq	%rax, %rsi
               	popq	%rbp
               	jmp	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	<rip>, %rbx # <addr>
               	movq	<rip>, %r12 # <addr>
               	movq	<rip>, %r13 # <addr>
               	movq	<rip>, %r14 # <addr>
               	movq	<rip>, %r15 # <addr>
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x48(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x40(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x38(%rsp)
               	callq	<addr>
               	leaq	(%rbx,%r12), %rcx
               	addq	%r13, %rcx
               	addq	%r14, %rcx
               	addq	%r15, %rcx
               	addq	0x48(%rsp), %rcx
               	addq	0x40(%rsp), %rcx
               	addq	0x38(%rsp), %rcx
               	addq	%rcx, %rax
               	movl	<rip>, %ecx # <addr>
               	xorl	%edx, %edx
               	movl	$0x4, %esi
               	cmpl	$0x2, %ecx
               	movq	%rsi, %rcx
               	cmoveq	%rdx, %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
