
designator_completes_a_union.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rdx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	<rip>, %rsi      # <addr>
               	leaq	<rip>, %rcx      # <addr>
               	leaq	<rip>, %rax      # <addr>
               	movsd	(%rsi), %xmm0
               	movabsq	$0x4004000000000000, %rdi # imm = 0x4004000000000000
               	movq	%rdi, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	movq	0x8(%rsi), %rsi
               	cmpq	$0x4, %rsi
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	je	<addr>
               	leave
               	retq
               	movsd	-0x10(%rbp), %xmm0
               	movq	%rdi, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movsd	-0x10(%rbp), %xmm0
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	xorl	%eax, %eax
               	imulq	$0x14, %rax, %rax
               	leave
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movl	(%rcx), %esi
               	cmpl	$0x1, %esi
               	jne	<addr>
               	movl	0x4(%rcx), %esi
               	cmpl	$0x2, %esi
               	jne	<addr>
               	movl	0x8(%rcx), %ecx
               	cmpl	$0x3, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	jmp	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x6, %rcx
               	jne	<addr>
               	movq	0x8(%rax), %rcx
               	cmpq	$0x7, %rcx
               	jne	<addr>
               	movl	0x10(%rax), %ecx
               	cmpl	$0x8, %ecx
               	jne	<addr>
               	movq	0x18(%rax), %rcx
               	cmpq	$0x9, %rcx
               	jne	<addr>
               	movl	0x20(%rax), %eax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
