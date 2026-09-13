
large_aggregate_copy.x64:	file format elf64-x86-64

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

<check>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x660, %rsp            # imm = 0x660
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x4658(%rbp), %rdx
               	movslq	%eax, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	movq	%rcx, %rdx
               	andq	$0x7f, %rdx
               	movb	%dl, (%rsi)
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x2328, %eax           # imm = 0x2328
               	jl	<addr>
               	leaq	-0x4658(%rbp), %rax
               	movl	$0x4d2, %ecx            # imm = 0x4D2
               	movl	%ecx, 0x2328(%rax)
               	movzbq	(%rax), %rdx
               	leaq	0x2000(%rax), %rcx
               	movzbq	(%rcx), %rsi
               	movl	0x2328(%rax), %ecx
               	xorq	%rax, %rax
               	movq	%rax, %rdi
               	movq	%rax, %rdi
               	movq	%rax, %rdi
               	movq	%rax, %rdi
               	movsbq	%dl, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movsbq	%sil, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	cmpl	$0x4d2, %ecx            # imm = 0x4D2
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	xorq	%rax, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
