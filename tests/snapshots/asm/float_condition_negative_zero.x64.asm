
float_condition_negative_zero.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorl	%ecx, %ecx
               	movabsq	$-0x8000000000000000, %rdx # imm = 0x8000000000000000
               	movl	$0x1, %eax
               	movq	%rdx, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	movq	%rcx, %r10
               	cmovpq	%rax, %r10
               	cmoveq	%r10, %rax
               	movq	%rcx, %xmm14
               	movq	%rdx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	sete	%sil
               	movzbq	%sil, %rsi
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rsi
               	movq	%rax, %rdi
               	orq	$0x2, %rdi
               	testq	%rsi, %rsi
               	cmovneq	%rax, %rdi
               	movq	%rcx, %rax
               	movq	%rdx, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	incq	%rax
               	cmpl	$0x2, %eax
               	jg	<addr>
               	movq	%rdx, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	jne	<addr>
               	movq	%rdi, %rcx
               	orq	$0x4, %rcx
               	testl	%eax, %eax
               	cmoveq	%rdi, %rcx
               	xorl	%eax, %eax
               	movq	%rcx, %rsi
               	orq	$0x8, %rsi
               	movq	%rdx, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	cmovneq	%rsi, %rcx
               	cmovpq	%rsi, %rcx
               	movq	%rcx, %rsi
               	orq	$0x10, %rsi
               	movq	%rdx, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	cmovneq	%rsi, %rcx
               	cmovpq	%rsi, %rcx
               	movq	%rcx, %rsi
               	orq	$0x20, %rsi
               	movq	%rdx, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	cmovneq	%rsi, %rcx
               	cmovpq	%rsi, %rcx
               	movq	%rcx, %rsi
               	orq	$0x40, %rsi
               	movq	%rdx, %xmm14
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm14
               	movq	%rcx, %r10
               	cmovpq	%rsi, %r10
               	cmoveq	%r10, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
