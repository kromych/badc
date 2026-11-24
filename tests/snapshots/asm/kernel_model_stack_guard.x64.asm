
kernel_model_stack_guard.x64:	file format elf64-x86-64

Disassembly of section .text:

<set_intr_gate>:
               	subq	$0x28, %rsp
               	movq	%gs:0x28, %r11
               	movq	%r11, 0x18(%rsp)
               	xorl	%r11d, %r11d
               	leaq	(%rsp), %rax
               	movl	%edi, (%rsp)
               	movl	$0x10, 0x4(%rsp)
               	movq	%rsi, 0x8(%rsp)
               	movq	$0x0, %rdi
		R_X86_64_32S	idt_table
               	movl	$0x1, %edx
               	xorl	%ecx, %ecx
               	movq	%rax, %rsi
               	callq	<addr>
		R_X86_64_PLT32	idt_setup_from_table-0x4
               	movq	%gs:0x28, %r11
               	cmpq	0x18(%rsp), %r11
               	je	<addr>
               	callq	<addr>
		R_X86_64_PLT32	__stack_chk_fail-0x4
               	xorl	%r11d, %r11d
               	addq	$0x28, %rsp
               	retq
