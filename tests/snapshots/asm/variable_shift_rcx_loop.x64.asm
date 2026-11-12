
variable_shift_rcx_loop.x64:	file format elf64-x86-64

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

<g>:
               	movq	%rcx, %rax
               	xorl	%ecx, %ecx
               	shlxq	%rdx, %rsi, %rsi
               	movq	%rcx, %rdx
               	cmpq	%rdi, %rdx
               	jge	<addr>
               	leaq	(%rcx,%rax), %rdx
               	addq	%rsi, %rcx
               	cmpq	%rdi, %rdx
               	jl	<addr>
               	retq

<main>:
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	leaq	0x1(%rax), %rcx
               	addq	$0x10, %rax
               	cmpq	$0x64, %rcx
               	jl	<addr>
               	xorl	%eax, %eax
               	retq
