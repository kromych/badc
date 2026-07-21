
alloca_arena_in_bounds.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x1f40, %edx           # imm = 0x1F40
               	movq	%rdx, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rbx
               	subq	%r11, %rbx
               	movq	%rbx, %rsp
               	movl	$0x3, %esi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	leaq	(%rbx,%rdx), %rsi
               	movzbq	(%rsi), %rsi
               	addq	%rsi, %rcx
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	$0x1f40, %rdx           # imm = 0x1F40
               	jl	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x5dc0, %rax           # imm = 0x5DC0
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	leaq	-0x40(%rbp), %rsp
               	movq	(%rsp), %rbx
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
