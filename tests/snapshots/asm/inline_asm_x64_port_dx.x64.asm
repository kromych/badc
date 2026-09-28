
inline_asm_x64_port_dx.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x70, %edx
               	inb	%dx, %al
               	andq	$0xff, %rax
               	movl	$0x70, %edx
               	outb	%al, %dx
               	movl	$0x70, %edx
               	inw	%dx, %ax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movl	$0x70, %edx
               	outw	%ax, %dx
               	movl	$0x70, %edx
               	inl	%dx, %eax
               	movl	%eax, %eax
               	movl	$0x70, %edx
               	outl	%eax, %dx
               	movl	$0x2a, %eax
               	retq
