
struct_member_copy_from_global.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<new_client>:
               	leaq	<rip>, %rax
               	movl	(%rax), %ecx
               	movl	$0x9, %edx
               	movl	%edx, (%rax)
               	movl	(%rax), %edx
               	movl	$0x1, %eax
               	movslq	%ecx, %rax
               	cmpq	$-0x1, %rax
               	jl	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	leaq	0x1(%rax), %rcx
               	movslq	%edx, %rsi
               	cmpq	$-0x1, %rsi
               	jl	<addr>
               	movl	$0x1, %eax
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
               	movabsq	$-0x64, %rax
               	jmp	<addr>

<main>:
               	xorq	%rax, %rax
               	leaq	<rip>, %rax
               	movl	(%rax), %ecx
               	movl	$0x9, %edx
               	movl	%edx, (%rax)
               	movl	(%rax), %edx
               	movl	$0x1, %eax
               	movslq	%ecx, %rax
               	cmpq	$-0x1, %rax
               	jl	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	leaq	0x1(%rax), %rcx
               	movslq	%edx, %rsi
               	cmpq	$-0x1, %rsi
               	jl	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	cmpq	$0x9, %rsi
               	jne	<addr>
               	xorq	%rcx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jge	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	movslq	%eax, %rax
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	movl	$0x64, %ecx
               	jmp	<addr>
               	movabsq	$-0x64, %rax
               	jmp	<addr>
               	movabsq	$-0x64, %rax
               	jmp	<addr>
