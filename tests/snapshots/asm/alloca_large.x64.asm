
alloca_large.x64:	file format elf64-x86-64

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
               	subq	$0x30, %rsp
               	movl	$0x100000, %eax         # imm = 0x100000
               	movq	%rax, %r11
               	addq	$0xf, %r11
               	andq	$-0x10, %r11
               	movq	%rsp, %rcx
               	subq	%r11, %rcx
               	movq	%rcx, %rsp
               	movl	$0x1, %eax
               	movb	%al, (%rcx)
               	leaq	0xfffff(%rcx), %rax
               	movl	$0x2, %edx
               	movb	%dl, (%rax)
               	movl	$0x1000, %eax           # imm = 0x1000
               	jmp	<addr>
               	leaq	(%rcx,%rax), %rdx
               	movl	$0x3, %esi
               	movb	%sil, (%rdx)
               	addq	$0x1000, %rax           # imm = 0x1000
               	cmpq	$0xfffff, %rax          # imm = 0xFFFFF
               	jl	<addr>
               	movsbq	(%rcx), %rax
               	addq	$0xfffff, %rcx          # imm = 0xFFFFF
               	movsbq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movl	$0x2a, %eax
               	movslq	%eax, %rax
               	leaq	-0x30(%rbp), %rsp
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
