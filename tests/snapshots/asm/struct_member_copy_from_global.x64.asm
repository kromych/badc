
struct_member_copy_from_global.x64:	file format elf64-x86-64

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

<new_client>:
               	leaq	<rip>, %rax
               	movl	(%rax), %edx
               	movl	$0x9, %ecx
               	movl	%ecx, (%rax)
               	movl	(%rax), %ecx
               	movl	$0x1, %eax
               	movq	%rax, %rsi
               	cmpl	$-0x1, %edx
               	jl	<addr>
               	movq	%rax, %rdx
               	movslq	%edx, %rdx
               	incq	%rdx
               	cmpl	$-0x1, %ecx
               	jl	<addr>
               	movslq	%eax, %rax
               	addq	%rdx, %rax
               	cmpl	$0x9, %ecx
               	jne	<addr>
               	xorq	%rcx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq
               	movl	$0x64, %ecx
               	jmp	<addr>
               	movabsq	$-0x64, %rax
               	jmp	<addr>
               	movabsq	$-0x64, %rdx
               	jmp	<addr>

<main>:
               	xorq	%rdx, %rdx
               	movq	%rdx, %rax
               	leaq	<rip>, %rax
               	movl	(%rax), %esi
               	movl	$0x9, %ecx
               	movl	%ecx, (%rax)
               	movl	(%rax), %ecx
               	movl	$0x1, %eax
               	movq	%rax, %rdi
               	cmpl	$-0x1, %esi
               	jl	<addr>
               	movq	%rax, %rsi
               	movslq	%esi, %rsi
               	incq	%rsi
               	cmpl	$-0x1, %ecx
               	jl	<addr>
               	movslq	%eax, %rax
               	addq	%rsi, %rax
               	cmpl	$0x9, %ecx
               	jne	<addr>
               	movq	%rdx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	testl	%eax, %eax
               	jge	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	movl	(%rax), %ecx
               	cmpl	$0x9, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	%rdx, %rax
               	retq
               	movl	$0x64, %ecx
               	jmp	<addr>
               	movabsq	$-0x64, %rax
               	jmp	<addr>
               	movabsq	$-0x64, %rsi
               	jmp	<addr>
