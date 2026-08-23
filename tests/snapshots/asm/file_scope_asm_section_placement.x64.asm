
file_scope_asm_section_placement.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	cmpl	$0x11112222, %eax       # imm = 0x11112222
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	cmpl	$0x33334444, %eax       # imm = 0x33334444
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax        # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x55556666, %eax       # imm = 0x55556666
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x77778888, %ecx       # imm = 0x77778888
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rax
               	movl	(%rax), %eax
               	cmpl	$0x77778888, %eax       # imm = 0x77778888
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x2a, %eax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	pushw	%bp
               	pushq	%rbp
