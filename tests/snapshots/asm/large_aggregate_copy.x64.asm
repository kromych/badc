
large_aggregate_copy.x64:	file format elf64-x86-64

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

<check>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x1000, %rsp           # imm = 0x1000
               	movq	$0x0, (%rsp)
               	subq	$0x330, %rsp            # imm = 0x330
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	andq	$0x7f, %rdx
               	movb	%dl, -0x2330(%rbp,%rax)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x2328, %eax           # imm = 0x2328
               	jl	<addr>
               	movl	$0x4d2, -0x8(%rbp)      # imm = 0x4D2
               	movzbq	-0x2330(%rbp), %rax
               	movzbq	-0x330(%rbp), %rcx
               	movsbq	%al, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movsbq	%cl, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq

<main>:
               	jmp	<addr>
