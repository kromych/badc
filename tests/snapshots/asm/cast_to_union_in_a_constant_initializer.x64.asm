
cast_to_union_in_a_constant_initializer.x64:	file format elf64-x86-64

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

<main>:
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movsd	(%rax), %xmm0
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx      # <addr>
               	cmpq	%rcx, %rax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movzbq	(%rax), %rcx
               	xorq	$0x7, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movq	(%rax), %rax
               	cmpq	$0x7, %rax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	0x8(%rax), %eax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	0x8(%rax), %ecx
               	cmpl	$0x8, %ecx
               	jne	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movsd	0x8(%rax), %xmm0
               	movabsq	$0x3ff8000000000000, %rcx # imm = 0x3FF8000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	0x10(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x67, %eax
               	jne	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	movl	0x8(%rax), %eax
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %eax
               	cmpl	$0xb, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x4, %eax
               	jmp	<addr>
               	movl	$0x2, %eax
               	retq
