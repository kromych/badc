
nested_function_calls.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400247 <.text+0x27>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movslq	%edi, %r11
               	movslq	%esi, %r9
               	movq	%r11, %r8
               	addq	%r9, %r8
               	movslq	%r8d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0xa, %ebx
               	movl	$0x14, %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %r14
               	movl	$0x1e, %r15d
               	movl	$0x28, %r12d
               	movq	%r15, %rdi
               	movq	%r12, %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rbx
               	movq	%r14, %rdi
               	movq	%rbx, %rsi
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	addq	$0x20, %rsp
               	popq	%rbp
               	jmp	0x400237 <.text+0x17>
               	addb	%al, 0x41(%rdx)
