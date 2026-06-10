
unsigned_div_in_assign.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x220, %esi            # imm = 0x220
               	callq	<addr>
               	ud2
               	movq	(%rdi), %rax
               	movl	$0x18, %ecx
               	pushq	%rax
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%rcx
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movl	$0x7, %edx
               	movq	%rdx, %r10
               	pushq	%rdx
               	xorq	%rdx, %rdx
               	divq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	movslq	%ecx, %rcx
               	imulq	$0x64, %rcx, %rcx
               	movslq	%ecx, %rcx
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%r11
               	movq	(%rcx), %r11
               	movq	%r11, (%rax)
               	popq	%r11
               	leaq	-0x8(%rbp), %rdi
               	callq	<addr>
               	cmpq	$0x3ea, %rax            # imm = 0x3EA
               	jne	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	jmp	<addr>
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
