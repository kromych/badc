
struct_basic.x64:	file format elf64-x86-64

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
               	movl	$0x8, %ebx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x400447 <malloc>
               	movq	%rax, %r9
               	movl	$0x3, %ebx
               	movl	%ebx, (%r9)
               	movq	%r9, %r8
               	addq	$0x4, %r8
               	movl	$0x4, %ebx
               	movl	%ebx, (%r8)
               	movslq	(%r9), %rdi
               	movslq	(%r9), %rbx
               	movq	%rdi, %r8
               	imulq	%rbx, %r8
               	movslq	%r8d, %r8
               	movq	%r9, %rbx
               	addq	$0x4, %rbx
               	movslq	(%rbx), %r9
               	movslq	(%rbx), %rdi
               	movq	%r9, %rbx
               	imulq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	movq	%r8, %rdi
               	addq	%rbx, %rdi
               	movslq	%edi, %rdi
               	movq	%rdi, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
