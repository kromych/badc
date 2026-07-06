
signal_sig_t.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<handler>:
               	xorq	%rax, %rax
               	retq

<main>:
               	leaq	-<rip>, %rax        # <addr>
               	xorq	%rcx, %rcx
               	leaq	-<rip>, %rdx       # <addr>
               	cmpq	%rdx, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, 0x41(%rdx)
