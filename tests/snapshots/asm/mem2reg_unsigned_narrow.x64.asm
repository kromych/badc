
mem2reg_unsigned_narrow.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	$0x12c, %r8d            # imm = 0x12C
               	movl	$0x12345, %eax          # imm = 0x12345
               	xorq	%rdx, %rdx
               	movq	%rdx, %rcx
               	movq	%rdx, %rsi
               	jmp	<addr>
               	movslq	%esi, %rdi
               	cmpq	$0x3, %rdi
               	jge	<addr>
               	movslq	%ecx, %rdi
               	movq	%r8, %rcx
               	andq	$0xff, %rcx
               	addq	%rcx, %rdi
               	movslq	%edi, %rcx
               	movslq	%edx, %rdi
               	movq	%rax, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	addq	%rdx, %rdi
               	movslq	%edi, %rdx
               	movslq	%esi, %rsi
               	addq	$0x1, %rsi
               	movslq	%esi, %rsi
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	andq	$0xff, %r8
               	xorq	$0x2c, %r8
               	movl	%r8d, %r8d
               	cmpq	$0x0, %r8
               	je	<addr>
               	movq	%rdi, %rsi
               	addq	$0x1, %rsi
               	movslq	%esi, %rdi
               	jmp	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	xorq	$0x2345, %rax           # imm = 0x2345
               	movl	%eax, %eax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movslq	%edi, %rax
               	addq	$0x2, %rax
               	movslq	%eax, %rdi
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x84, %rax
               	je	<addr>
               	movslq	%edi, %rax
               	addq	$0x4, %rax
               	movslq	%eax, %rdi
               	jmp	<addr>
               	movslq	%edx, %rax
               	cmpq	$0x69cf, %rax           # imm = 0x69CF
               	je	<addr>
               	movslq	%edi, %rax
               	addq	$0x8, %rax
               	movslq	%eax, %rdi
               	jmp	<addr>
               	movslq	%edi, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	addb	%al, (%rax)
