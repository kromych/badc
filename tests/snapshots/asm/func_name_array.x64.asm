
func_name_array.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rdx
               	xorq	%rax, %rax
               	jmp	<addr>
               	movslq	%eax, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	movsbq	(%rsi), %rsi
               	leaq	<rip>, %rdi
               	addq	%rcx, %rdi
               	movsbq	(%rdi), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	xorq	%rax, %rax
               	retq
               	movl	$0x2, %eax
               	retq
