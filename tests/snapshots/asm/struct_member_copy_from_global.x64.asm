
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
               	movl	(%rax), %ecx
               	movl	$0x9, %edx
               	movl	%edx, (%rax)
               	movl	(%rax), %edx
               	movl	$0x1, %eax
               	movq	%rax, %rsi
               	movslq	%ecx, %rcx
               	cmpq	$-0x1, %rcx
               	jl	<addr>
               	movq	%rax, %rcx
               	movslq	%ecx, %rcx
               	incq	%rcx
               	movslq	%edx, %rsi
               	cmpq	$-0x1, %rsi
               	jl	<addr>
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	cmpq	$0x9, %rsi
               	jne	<addr>
               	xorq	%rcx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq
               	movl	$0x64, %ecx
               	jmp	<addr>
               	movabsq	$-0x64, %rax
               	jmp	<addr>
               	movabsq	$-0x64, %rcx
               	jmp	<addr>

<main>:
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	leaq	<rip>, %rax
               	movl	(%rax), %esi
               	movl	$0x9, %edx
               	movl	%edx, (%rax)
               	movl	(%rax), %edx
               	movl	$0x1, %eax
               	movq	%rax, %rdi
               	movslq	%esi, %rsi
               	cmpq	$-0x1, %rsi
               	jl	<addr>
               	movq	%rax, %rsi
               	movslq	%esi, %rsi
               	incq	%rsi
               	movslq	%edx, %rdi
               	cmpq	$-0x1, %rdi
               	jl	<addr>
               	movslq	%eax, %rax
               	addq	%rsi, %rax
               	cmpq	$0x9, %rdi
               	jne	<addr>
               	movq	%rcx, %rdx
               	addq	%rdx, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jge	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	movl	(%rax), %edx
               	movslq	%edx, %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	%rcx, %rax
               	retq
               	movl	$0x64, %edx
               	jmp	<addr>
               	movabsq	$-0x64, %rax
               	jmp	<addr>
               	movabsq	$-0x64, %rsi
               	jmp	<addr>
