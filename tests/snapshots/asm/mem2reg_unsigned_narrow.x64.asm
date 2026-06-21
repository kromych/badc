
mem2reg_unsigned_narrow.x64:	file format elf64-x86-64

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
               	movq	%r13, (%rsp)
               	movl	$0x12c, %eax            # imm = 0x12C
               	movl	$0x12345, %ecx          # imm = 0x12345
               	xorq	%rsi, %rsi
               	movq	%rsi, %rdx
               	movq	%rsi, %rdi
               	movslq	%edi, %r8
               	cmpq	$0x3, %r8
               	jge	<addr>
               	movslq	%edx, %rdx
               	movq	%rax, %r8
               	andq	$0xff, %r8
               	addq	%r8, %rdx
               	movslq	%edx, %rdx
               	movslq	%esi, %rsi
               	movq	%rcx, %r8
               	andq	$0xffff, %r8            # imm = 0xFFFF
               	addq	%r8, %rsi
               	movslq	%esi, %rsi
               	movslq	%edi, %rdi
               	incq	%rdi
               	movslq	%edi, %rdi
               	jmp	<addr>
               	xorq	%r8, %r8
               	andq	$0xff, %rax
               	xorq	$0x2c, %rax
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%r8, %rax
               	incq	%rax
               	movslq	%eax, %r8
               	movq	%rcx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	xorq	$0x2345, %rax           # imm = 0x2345
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%r8d, %rax
               	addq	$0x2, %rax
               	movslq	%eax, %r8
               	movslq	%edx, %rax
               	cmpq	$0x84, %rax
               	je	<addr>
               	movslq	%r8d, %rax
               	addq	$0x4, %rax
               	movslq	%eax, %r8
               	movslq	%esi, %rax
               	cmpq	$0x69cf, %rax           # imm = 0x69CF
               	je	<addr>
               	movslq	%r8d, %rax
               	addq	$0x8, %rax
               	movslq	%eax, %r8
               	movslq	%r8d, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %r13
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
