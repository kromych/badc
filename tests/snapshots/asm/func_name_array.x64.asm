
func_name_array.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	leaq	<rip>, %rdx
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	(%rdx,%rcx), %rsi
               	movsbq	(%rsi), %rsi
               	leaq	<rip>, %rdi
               	addq	%rcx, %rdi
               	movsbq	(%rdi), %rdi
               	cmpq	%rdi, %rsi
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x5, %rcx
               	jl	<addr>
               	xorq	%rax, %rax
               	retq
               	movl	$0x2, %eax
               	retq
               	movl	$0x1, %eax
               	retq
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
