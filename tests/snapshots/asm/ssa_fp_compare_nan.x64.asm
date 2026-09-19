
ssa_fp_compare_nan.x64:	file format elf64-x86-64

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
               	xorq	%rcx, %rcx
               	movq	%rcx, %xmm15
               	movq	%rcx, %xmm0
               	divsd	%xmm15, %xmm0
               	movq	%rcx, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jbe	<addr>
               	movl	$0x1, %eax
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jbe	<addr>
               	orq	$0x2, %rax
               	movq	%rcx, %xmm15
               	ucomisd	%xmm0, %xmm15
               	jb	<addr>
               	orq	$0x4, %rax
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jb	<addr>
               	orq	$0x8, %rax
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	orq	$0x10, %rax
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	jne	<addr>
               	orq	$0x20, %rax
               	ucomisd	%xmm0, %xmm0
               	jbe	<addr>
               	orq	$0x40, %rax
               	ucomisd	%xmm0, %xmm0
               	jp	<addr>
               	jne	<addr>
               	orq	$0x80, %rax
               	movslq	%eax, %rsi
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
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	movq	%rcx, %rax
               	jmp	<addr>
