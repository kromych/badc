
setjmp_basic_stack.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400277 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe51(%rip)           # 0x4100c8
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x220, %rsp            # imm = 0x220
               	movq	%rbx, (%rsp)
               	leaq	-0x200(%rbp), %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x4003f7 <setjmp>
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x220, %rsp            # imm = 0x220
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
