
cast_to_struct_pointer.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400287 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe51(%rip)           # 0x4100d8
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x10, %ebx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x400417 <malloc>
               	movq	%rax, %r9
               	movl	$0x2a, %ebx
               	movl	%ebx, (%r9)
               	movq	%r9, %r8
               	addq	$0x8, %r8
               	xorq	%rbx, %rbx
               	movq	%rbx, (%r8)
               	movslq	(%r9), %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
