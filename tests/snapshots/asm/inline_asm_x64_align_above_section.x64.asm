
inline_asm_x64_align_above_section.x64:	file format elf64-x86-64

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
               	int3
               	int3

<main>:
               	leaq	-<rip>, %rax        # <addr>
               	testb	$0x3f, %al
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	nopl	(%rax)
               	nopw	%cs:(%rax,%rax)
               	leaq	-<rip>, %rax        # <addr>
               	testb	$0x1f, %al
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movl	$0x2a, %eax
               	retq
