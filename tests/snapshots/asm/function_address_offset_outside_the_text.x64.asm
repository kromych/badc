
function_address_offset_outside_the_text.x64:	file format elf64-x86-64

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

<f>:
               	movl	$0x1, %eax
               	retq

<main>:
               	leaq	-<rip>, %rax # <addr>
               	leaq	<rip>, %rcx # <addr>
               	movq	(%rcx), %rcx
               	movq	%rax, %rdx
               	subq	%rcx, %rdx
               	cmpq	$0x186a0, %rdx          # imm = 0x186A0
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movq	(%rcx), %rcx
               	movq	%rax, %rdx
               	subq	%rcx, %rdx
               	cmpq	$0x1, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movq	(%rcx), %rcx
               	subq	%rax, %rcx
               	cmpq	$0x10000000, %rcx       # imm = 0x10000000
               	jne	<addr>
               	leaq	<rip>, %rcx # <addr>
               	movq	(%rcx), %rcx
               	subq	%rax, %rcx
               	movabsq	$0x100000000000, %r11   # imm = 0x100000000000
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorl	%eax, %eax
               	retq
