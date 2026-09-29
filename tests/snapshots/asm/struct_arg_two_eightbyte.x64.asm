
struct_arg_two_eightbyte.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rdx      # <addr>
               	movl	$0x9, (%rdx)
               	leaq	<rip>, %rsi      # <addr>
               	movq	$0x1111, (%rsi)         # imm = 0x1111
               	leaq	<rip>, %rdi      # <addr>
               	movl	$0x4, (%rdi)
               	leaq	<rip>, %r8       # <addr>
               	movq	$0x2222, (%r8)          # imm = 0x2222
               	leaq	<rip>, %r9       # <addr>
               	movl	$0x6, (%r9)
               	movslq	(%rdx), %rdx
               	cmpl	$0x9, %edx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	(%rsi), %rdx
               	cmpq	$0x1111, %rdx           # imm = 0x1111
               	jne	<addr>
               	movl	(%rdi), %edx
               	xorq	$0x4, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	(%r8), %rdx
               	cmpq	$0x2222, %rdx           # imm = 0x2222
               	jne	<addr>
               	leaq	<rip>, %rdx      # <addr>
               	movl	(%rdx), %edx
               	xorq	$0x6, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rdx      # <addr>
               	movq	$0x1111, (%rdx)         # imm = 0x1111
               	leaq	<rip>, %rsi      # <addr>
               	movl	$0x4, %eax
               	movl	%eax, (%rsi)
               	leaq	<rip>, %rdi      # <addr>
               	movq	$0x2222, (%rdi)         # imm = 0x2222
               	leaq	<rip>, %rcx      # <addr>
               	movl	$0x6, (%rcx)
               	movq	(%rdx), %rdx
               	cmpq	$0x1111, %rdx           # imm = 0x1111
               	jne	<addr>
               	movl	(%rsi), %edx
               	xorq	$0x4, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	retq
               	movq	(%rdi), %rax
               	cmpq	$0x2222, %rax           # imm = 0x2222
               	jne	<addr>
               	movl	(%rcx), %eax
               	xorq	$0x6, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorl	%eax, %eax
               	retq
