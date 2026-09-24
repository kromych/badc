
sieve_of_eratosthenes.x64:	file format elf64-x86-64

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
               	movl	$0x2, %ecx
               	leaq	<rip>, %rdx
               	movq	%rcx, %rax
               	imulq	%rcx, %rax
               	cmpb	$0x0, (%rdx,%rcx)
               	jne	<addr>
               	cmpl	$0x186a0, %eax          # imm = 0x186A0
               	jge	<addr>
               	movb	$0x1, (%rdx,%rax)
               	addq	%rcx, %rax
               	cmpl	$0x186a0, %eax          # imm = 0x186A0
               	jl	<addr>
               	incq	%rcx
               	movq	%rcx, %rax
               	imulq	%rcx, %rax
               	cmpq	$0x186a0, %rax          # imm = 0x186A0
               	jl	<addr>
               	xorl	%eax, %eax
               	movl	$0x2, %ecx
               	leaq	<rip>, %rdx
               	cmpb	$0x0, (%rdx,%rcx)
               	jne	<addr>
               	incq	%rax
               	incq	%rcx
               	cmpl	$0x186a0, %ecx          # imm = 0x186A0
               	jl	<addr>
               	cmpl	$0x2578, %eax           # imm = 0x2578
               	jne	<addr>
               	xorl	%eax, %eax
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
